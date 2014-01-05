require 'gruff'
require 'benchmark'

class Benchpress 

  # step - increment
  # min - minimum # of profiles to run
  # max - maximum # of profiles to run
  # entities - data methods to run against
  def initialize(opts = {})
    @step = opts[:step] || 1
    @min  = opts[:min]  || 0
    @max  = opts[:max]  || 1000
    @entities = opts[:entities]
  end

  def step_points
    @step_points ||= (@min..@max).select { |i| i % @step == 0 }
  end

  def calculate_data_points
    @entities.each do |entity|
      step_points.each do |n|
        entity.data_points << Benchmark.measure { n.times { entity.method.call } }.real
      end
    end
  end

  def render
    calculate_data_points

    Gruff::Line.new.tap do |g|
      g.labels = step_points.each_with_index.reduce({}) { |hash, (val, index)| 
        index.odd? ? hash : hash.merge!({ index => val.to_s }) 
      }
      g.theme = Gruff::Themes::KEYNOTE
      @entities.each { |entity| g.data entity.name.to_sym, entity.data_points }
      g.write "#{Time.now.strftime '%Y-%m-%d-%H:%M:%S'}.png"
    end
  end
end

class Entity
  attr_reader :method, :name
  attr_accessor :data_points

  # color - line color
  # method - what are we benchmarking?
  def initialize(opts = {})
    @method = opts[:method]
    @name   = opts[:name] || ''
    @data_points = []
  end
end

# Example Code
e1 = Entity.new(name: 'symbol', method: -> { :symbol })
e2 = Entity.new(name: 'string', method: -> { 'string' })
e3 = Entity.new(name: 'integer', method: -> { 0 })
e4 = Entity.new(name: 'hash', method: -> { {} })
e5 = Entity.new(name: 'array', method: -> { [] })

b = Benchpress.new(entities: [e1, e2, e3, e4, e5], min: 100_000, max: 1_000_000, step: 10_000)
p b.render
