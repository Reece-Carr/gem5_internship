Based off Jason's MSI protocol in the "Learning Gem5" book.
Modifications:
- Added (caching) DMA controller based on the cache controller
- Changed directory entry to inherit from AbstractCacheEntry instead of
  AbstractEntry. As far as I can tell, it seems gem5 has moved on from
  the latter.
- As a result of the above, added manually sending requests to main memory
  instead of using pre-defined functions from AbstractEntry.
