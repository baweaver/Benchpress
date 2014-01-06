module Benchpress
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
end
