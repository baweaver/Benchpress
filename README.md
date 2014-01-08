Benchpress
==========

Pit a few ruby methods against eachother, and chart it for great glory.

Props to the folks at Gruff (https://github.com/topfunky/gruff) for making this simpler to do, and to the Ruby team behind Benchmark.

## How to Benchpress

We're going to need to define a chart.

```ruby
c = Benchpress::Chart.new(
  entities: {
    string: -> { 'string' },
    symbol: -> { :symbol  }
  },
  min: 10_000,               # Minimum times to run. Default: 0
  max: 100_000,              # Maximum times to run. Default: 1_000
  step: 10_000,              # Step rate for next benchmark. Default: 1
  name: 'string_vs_symbol',  # File name. Default: 'Time.now.strftime '%Y-%m-%d-%H:%M:%S''
  format: 'png'              # File format. Default: png
)
```

and then render it:
```ruby
c.render # Line chart

c.render :line # Line chart
c.render :bar  # Bar chart
```

![](new pic url)

Voila! Instant chart with realtime benchmarks to demonstrate complexities of methods everywhere! Supports an arbitrary number of entities.
