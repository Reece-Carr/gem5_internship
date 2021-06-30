# -*- coding: utf-8 -*-
# Copyright (c) 2017 Jason Power
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met: redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer;
# redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution;
# neither the name of the copyright holders nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

""" This file creates a set of Ruby caches, the Ruby network, and a simple
point-to-point topology.
See Part 3 in the Learning gem5 book:
http://gem5.org/documentation/learning_gem5/part3/MSIintro

IMPORTANT: If you modify this file, it's likely that the Learning gem5 book
           also needs to be updated. For now, email Jason <jason@lowepower.com>

"""

import math
import m5
from m5.objects import *
from m5.defines import buildEnv
from .Ruby import create_topology, create_directories
from .Ruby import send_evicts

def define_options(parser):
    return

def create_system(options, full_system, system, dma_ports, bootmem,
                  ruby_system):

    if buildEnv['PROTOCOL'] != 'JASON_MSI':
        panic("This script requires the JASON_MSI protocol to be built.")

    cpu_sequencers = []

    #
    # The ruby network creation expects the list of nodes in the system to be
    # consistent with the NetDest list.  Therefore the l1 controller nodes must
    # be listed before the directory nodes and directory nodes before dma nodes
    # etc.
    #
    l1_cntrl_nodes = [
            L1Cache(system,
                    ruby_system,
                    system.cpu[i],
                    cpu_sequencers,
                    options)
            for i in range(options.num_cpus)
            ]

    for i, l1_cntrl in enumerate(l1_cntrl_nodes):
        exec("ruby_system.l1_cntrl%d = l1_cntrl" % i)

    # Run each of the ruby memory controllers at a ratio of the frequency of
    # the ruby system
    # clk_divider value is a fix to pass regression.
    ruby_system.memctrl_clk_domain = DerivedClockDomain(
                                          clk_domain = ruby_system.clk_domain,
                                          clk_divider = 3)

    mem_dir_cntrl_nodes, rom_dir_cntrl_node = create_directories(
        options, bootmem, ruby_system, system)
    dir_cntrl_nodes = mem_dir_cntrl_nodes[:]
    if rom_dir_cntrl_node is not None:
        dir_cntrl_nodes.append(rom_dir_cntrl_node)
    for dir_cntrl in dir_cntrl_nodes:
        print("Looping over dir_cntrl")
        # Connect the directory controllers and the network
        dir_cntrl.requestFromCache = MessageBuffer(ordered = False)
        dir_cntrl.requestFromCache.slave = ruby_system.network.master
        dir_cntrl.responseFromCache= MessageBuffer(ordered = False)
        dir_cntrl.responseFromCache.slave = ruby_system.network.master

        dir_cntrl.responseToCache = MessageBuffer(ordered = False)
        dir_cntrl.responseToCache.master = ruby_system.network.slave
        dir_cntrl.forwardToCache = MessageBuffer(ordered = True)
        dir_cntrl.forwardToCache.master = ruby_system.network.slave

        dir_cntrl.requestToMemory = MessageBuffer()
        dir_cntrl.responseFromMemory = MessageBuffer()

    dma_cntrl_nodes = []
    for i, dma_port in enumerate(dma_ports):
        print("Looping over dma_port")
        #
        # Create the Ruby objects associated with the dma controller
        #
        dma_seq = DMASequencer(version = i,
                               ruby_system = ruby_system, slave=dma_port)

        dma_cntrl = DMA_Controller(version = i,
                                   dma_sequencer = dma_seq,
                                   transitions_per_cycle = options.ports,
                                   ruby_system = ruby_system)

        # This is the cache memory object that stores the cache data and tags
        dma_cntrl.cacheMemory = RubyCache(size = options.l1d_size,
                                    assoc = options.l1d_assoc,
                                    start_index_bit = getBlockSizeBits(
                                         system))

        exec("ruby_system.dma_cntrl%d = dma_cntrl" % i)
        #exec("ruby_system.dma_cntrl%d.dma_sequencer.slave = dma_port" % i)
        dma_cntrl_nodes.append(dma_cntrl)
        dma_cntrl.mandatoryQueue = MessageBuffer()
        dma_cntrl.requestToDir = MessageBuffer(ordered = False)
        dma_cntrl.requestToDir.master = ruby_system.network.slave
        dma_cntrl.responseToDirOrSibling = MessageBuffer(ordered = False)
        dma_cntrl.responseToDirOrSibling.master = ruby_system.network.slave
        dma_cntrl.forwardFromDir = MessageBuffer(ordered = True)
        dma_cntrl.forwardFromDir.slave = ruby_system.network.master
        dma_cntrl.responseFromDirOrSibling = MessageBuffer(ordered = False)
        dma_cntrl.responseFromDirOrSibling.slave = ruby_system.network.master

    all_cntrls = l1_cntrl_nodes + dir_cntrl_nodes + dma_cntrl_nodes

    if full_system:
        print("Setting up io_controller")
        io_seq = DMASequencer(version=len(dma_ports), ruby_system=ruby_system)
        ruby_system._io_port = io_seq
        io_controller = DMA_Controller(version = len(dma_ports),
                                       dma_sequencer = io_seq,
                                       ruby_system = ruby_system)
        io_controller.cacheMemory = RubyCache(size = options.l1d_size,
                                    assoc = options.l1d_assoc,
                                    start_index_bit = getBlockSizeBits(
                                         system))
        ruby_system.io_controller = io_controller

        io_controller.mandatoryQueue = MessageBuffer()
        io_controller.requestToDir = MessageBuffer(ordered = False)
        io_controller.requestToDir.master = ruby_system.network.slave
        io_controller.responseToDirOrSibling = MessageBuffer(ordered = False)
        io_controller.responseToDirOrSibling.master = ruby_system.network.slave
        io_controller.forwardFromDir = MessageBuffer(ordered = True)
        io_controller.forwardFromDir.slave = ruby_system.network.master
        io_controller.responseFromDirOrSibling = MessageBuffer(ordered = False)
        io_controller.responseFromDirOrSibling.slave = \
            ruby_system.network.master

        all_cntrls.append(io_controller)

    ruby_system.network.number_of_virtual_networks = 6
    topology = create_topology(all_cntrls, options)
    return (cpu_sequencers, dir_cntrl_nodes, topology)


class L1Cache(L1Cache_Controller):

    _version = 0
    @classmethod
    def versionCount(cls):
        cls._version += 1 # Use count for this particular type
        return cls._version - 1

    def __init__(self, system, ruby_system, cpu, cpu_seqs, options):
        """CPUs are needed to grab the clock domain and system is needed for
           the cache block size.
        """
        super(L1Cache, self).__init__()

        self.version = self.versionCount()
        # This is the cache memory object that stores the cache data and tags
        self.cacheMemory = RubyCache(size = options.l1d_size,
                                     assoc = options.l1d_assoc,
                                     start_index_bit = getBlockSizeBits(
                                         system))
        self.clk_domain = cpu.clk_domain
        self.send_evictions = send_evicts(options)
        self.ruby_system = ruby_system


        self.sequencer = RubySequencer(version=self.version,
                                       icache=self.cacheMemory,
                                       dcache=self.cacheMemory,
                                       clk_domain=cpu.clk_domain,
                                       ruby_system=ruby_system)

        cpu_seqs.append(self.sequencer)
        self.connectQueues(ruby_system)

    def getBlockSizeBits(self, system):
        bits = int(math.log(system.cache_line_size, 2))
        if 2**bits != system.cache_line_size.value:
            panic("Cache line size not a power of 2!")
        return bits

    def sendEvicts(self, cpu):
        """True if the CPU model or ISA requires sending evictions from caches
           to the CPU. Two scenarios warrant forwarding evictions to the CPU:
           1. The O3 model must keep the LSQ coherent with the caches
           2. The x86 mwait instruction is built on top of coherence
           3. The local exclusive monitor in ARM systems
        """
        if type(cpu) is DerivO3CPU or \
           buildEnv['TARGET_ISA'] in ('x86', 'arm'):
            return True
        return False

    def connectQueues(self, ruby_system):
        """Connect all of the queues for this controller.
        """
        # mandatoryQueue is a special variable. It is used by the sequencer to
        # send RubyRequests from the CPU (or other processor). It isn't
        # explicitly connected to anything.
        self.mandatoryQueue = MessageBuffer()

        # All message buffers must be created and connected to the general
        # Ruby network. In this case, "slave/master" don't mean the same thing
        # as normal gem5 ports. If a MessageBuffer is a "to" buffer (i.e., out)
        # then you use the "master", otherwise, the slave.
        self.requestToDir = MessageBuffer(ordered = False)
        self.requestToDir.master = ruby_system.network.slave
        self.responseToDirOrSibling = MessageBuffer(ordered = False)
        self.responseToDirOrSibling.master = ruby_system.network.slave
        self.forwardFromDir = MessageBuffer(ordered = True)
        self.forwardFromDir.slave = ruby_system.network.master
        self.responseFromDirOrSibling = MessageBuffer(ordered = False)
        self.responseFromDirOrSibling.slave = ruby_system.network.master

def getBlockSizeBits(system):
    bits = int(math.log(system.cache_line_size, 2))
    if 2**bits != system.cache_line_size.value:
        panic("Cache line size not a power of 2!")
    return bits
