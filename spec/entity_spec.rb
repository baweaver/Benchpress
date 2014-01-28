require 'spec_helper'


# No need for let or ivar if I don't intend to mutate.
step_points   = [1,2,3,4]
cycled_entity = Benchpress::Entity.new(step_points, 3, string: -> {'s'})
entity        = Benchpress::Entity.new(step_points, 1, string: -> {'s'})

describe 'Benchpress::Entity' do
  describe '#data' do
    it 'returns an array with the method name and data points' do
      name, data = entity.data

      expect(name).to eq('string')
      expect(data.length).to eq(4)
    end

    it 'does the same for a cycled entity' do
      name, data = cycled_entity.data

      expect(name).to eq('string')
      expect(data.length).to eq(4)
    end
  end
end