Benchpress
==========

[![Code Climate](https://codeclimate.com/github/baweaver/Benchpress.png)](https://codeclimate.com/github/baweaver/Benchpress)

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
  min: 50_000,               # Minimum times to run. Default: 0
  max: 100_000,              # Maximum times to run. Default: 1_000
  step: 10_000,              # Step rate for next benchmark. Default: 250
  cycles: 3,                 # How many times to repeat, so as to get an average. Default: 1
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

![](http://i42.tinypic.com/24oc0mo.png)

![](http://i42.tinypic.com/2uj2xio.png)

Voila! Instant chart with realtime benchmarks to demonstrate complexities of methods everywhere! Supports an arbitrary number of entities.

Want something a tinge more beefy and realistic? How about parsing 9 megs of JSON?

```ruby
c = Benchpress::Chart.new(
  entities: {
    oj: -> { Oj.load json },
    json: -> { JSON.load json}
  },
  max: 10,
  step: 2,
  name: '9m-json-bar'
)

c.render :bar

```

![](http://i40.tinypic.com/v4xpwg.png)
