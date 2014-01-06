module Benchpress
  class Chart
    # step - increment
    # min - minimum # of profiles to run
    # max - maximum # of profiles to run
    # entities - data methods to run against
    def initialize(opts = {})
      @step = opts[:step] || 1
      @min  = opts[:min]  || 0
      @max  = opts[:max]  || 1000
      @entities = opts[:entities]
      @name = "#{opts[:name]}.png" || "#{Time.now.strftime '%Y-%m-%d-%H:%M:%S'}.png"
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

      Gruff::Line.new.tap { |g|
        g.labels = step_points.each_with_index.reduce({}) { |hash, (val, index)|
          index.odd? ? hash : hash.merge!({ index => val.to_s })
        }
        g.theme = Gruff::Themes::THIRTYSEVEN_SIGNALS
        @entities.each { |entity| g.data entity.name.to_sym, entity.data_points }
        g.x_axis_label = 'Times (n)'
        g.y_axis_label = 'Length (seconds)'
      }.write @name
    end
  end
end
