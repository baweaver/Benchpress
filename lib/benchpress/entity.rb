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
    def initialize(steps, cycles, opts = {})
      raise 'Invalid formatting! Use "name: -> { method }"' unless opts.keys.length == 1
      @cycles        = cycles
      @steps         = steps
      @name, @method = *opts.flatten
    end

    def data
      [@name.to_s, flatten_data(cycle_data)]
    end

    private

    def cycle_data
      @cycles.times.reduce([]) { |table, _| table << measure_realtime }
    end

    def measure_realtime
      @steps.reduce([]) { |data, n| data << Benchmark.measure { n.times { @method.call } }.real }
    end

    def flatten_data(table)
      if table.length == 1
        table.flatten
      else
        table.transpose.reduce([]) { |ary, data| ary << (data.reduce(:+) / data.length) }
      end
    end 
  end
end
