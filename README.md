Benchpress
==========

Pit a few ruby methods against eachother, and chart it for great glory.

Fair warning, this is super alpha one hour quick hack type material here. The current version of 0.0.1 will work fine for trivial tasks, but I do need to put time into making it a more robust framework to use.

Props to the folks at Gruff (https://github.com/topfunky/gruff) for making this simpler to do, and to the Ruby team behind Benchmark.

## How to Benchpress

First we're going to need a few methods to shoot against:
```ruby
e1 = Benchpress::Entity.new(name: 'symbol', method: -> { :symbol })
e2 = Benchpress::Entity.new(name: 'string', method: -> { 'string' })
```

Now we're going to need to define a chart.
```ruby
c = Benchpress::Chart.new(
  entities: [e1, e2],
  min: 10_000,               # Minimum times to run. Default: 0
  max: 100_000,              # Maximum times to run. Default: 1_000
  step: 10_000,              # Step rate for next benchmark. Default: 1
  name: 'string_vs_symbol',  # File name. Default: 'Time.now.strftime '%Y-%m-%d-%H:%M:%S''
  format: 'png'              # File format. Default: png
)
```

and then render it:
```ruby
c.render
```

![](http://i39.tinypic.com/2i11mc0.png)

Voila! Instant chart with realtime benchmarks to demonstrate complexities of methods everywhere! Supports an arbitrary number of entities.

Known issues:
* X Axis labels do admittedly get nasty when there are too many of them. It does seem to misbehave a tinge. Fixes on the way for 0.0.2.
