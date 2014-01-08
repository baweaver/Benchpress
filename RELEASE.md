# v0.0.1

Initial release

# v1.0.0

## Bug Fixes

* Data points accumulating between runs on same entities

## Changes

* Entities are no longer directly instantiated
  * Entities are passed as a hash, in which the keys are the entities name, and the values are methods.
* Increase in rendering options
  * Can now render bar charts.
* More efficient stepping algorithm, decreases runtime.
