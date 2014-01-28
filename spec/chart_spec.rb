require 'spec_helper'

chart = Benchpress::Chart.new(
  entities: {
    string: -> { 'string' },
    symbol: -> { :symbol  }
  },
  min: 50_000,               # Minimum times to run. Default: 0
  max: 100_000,              # Maximum times to run. Default: 1_000
  step: 10_000,              # Step rate for next benchmark. Default: 1
  name: 'string_vs_symbol',  # File name. Default: 'Time.now.strftime '%Y-%m-%d-%H:%M:%S''
  format: 'png'              # File format. Default: png
)

step_points = [50000, 60000, 70000, 80000, 90000, 100000]

describe 'Benchpress::Chart' do
  describe '#image_name' do
    it 'will return a file name' do
      expect(chart.image_name).to eq('string_vs_symbol.png')
    end
  end

  describe '#step_points' do
    it 'will return an array of step points' do
      expect(chart.step_points).to eq(step_points)
    end
  end
end