module Benchpress
  class Chart

    # format   - format of the file
    # max      - maximum # of profiles to run
    # min      - minimum # of profiles to run
    # name     - name of the file
    # step     - increment rate
    # theme    - theme of the chart
    # entities - data methods to run against
    def initialize(opts = {})
      @cycles   = opts[:cycles] || 1
      @format   = opts[:format] || 'png'
      @max      = opts[:max]    || 1000
      @min      = opts[:min]    || 0
      @name     = opts[:name]   || "#{Time.now.strftime '%Y-%m-%d-%H:%M:%S'}"
      @step     = opts[:step]   || 250
      @theme    = opts[:theme]  || Gruff::Themes::THIRTYSEVEN_SIGNALS
      @entities = parse_entities opts[:entities]
    end

    # Render dispatcher. Note to refactor a tinge later.
    def render(type = :line)
      create_chart_data_for(
        case type
        when :line then Gruff::Line.new
        when :bar  then Gruff::Bar.new
        end
      ).write image_name
    end

    # file_name.ext
    def image_name
      @name + '.' + @format
    end

    # Calculates Step Points
    #
    # (min / step) will render 0 unless min is greater than the step rate, giving the floor of the range
    # (max / step) will render the maximum amount of times step will fit in the max wholly
    #
    # Caveat - If the max % step != 0, it will not render to the max. This is intended behavior.
    def step_points
      raise 'Cannot have larger step than max' if @step > @max

      @step_points ||= ((@min / @step)..(@max / @step)).reduce([]) { |steps, i| steps << @step * i }
    end

    private

    # Get labels for every point
    def all_labels
      step_points.each_with_index.reduce({}) { |hash, (val, index)| hash.merge!({ index => val.to_s }) }
    end

    # Lets you parse in entities by passing a hash in.
    #
    #   Benchpress::Chart.new(
    #     entities: {
    #       string: -> { 'string' }
    #       symbol: -> { :symbol  }
    #     }
    #   )
    def parse_entities(entities)
      raise 'Must have entities' unless entities

      @entities = entities.reduce([]) { |ary, (name, method)| 
        ary << Entity.new(step_points, @cycles, name => method) 
      }
    end

    def create_chart_data_for(chart)
      chart.tap { |g|
        g.labels = all_labels
        g.theme = @theme
        g.x_axis_label = 'Times Run (n)'
        g.y_axis_label = 'Length (seconds)'

        @entities.each { |entity| g.data *entity.data }
      }
    end
  end
end
