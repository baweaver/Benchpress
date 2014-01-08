module Benchpress
  class Entity
    attr_reader :method, :name
    attr_accessor :data_points

    # Pass in the name of the entity as a symbol, and its method as a lambda
    #
    # Ex:
    #   Benchpress::Entity.new(string: -> { 'string' })
    #
    # Warning: Direct instantiation has been deprecated, read the
    def initialize(opts = {})
      raise 'Invalid formatting! Use "name: -> { method }"' unless opts.keys.length == 1
      @name, @method = *opts.flatten
      @data_points = []
    end

    def render_data(step_points)
      @data_points.clear
      step_points.each { |n| @data_points << Benchmark.measure { n.times { @method.call } }.real }
    end

    def data
      [@name.to_s, @data_points]
    end
  end
end
