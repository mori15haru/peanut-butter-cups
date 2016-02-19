require 'spec_helper'
require './vector'

describe Vec do
  let(:v) { Vec.new([2,8,1]) }
  let(:u) { Vec.new([5,-4,7]) }
  let(:k) { 2 }

  describe '.x' do
    it 'returns x coordinate' do
      expect(v.x).to eq(2)
    end
  end

  describe '.y' do
    it 'returns y coordinate' do
      expect(v.y).to eq(8)
    end
  end

  describe '.z' do
    it 'returns z coordinate' do
      expect(v.z).to eq(1)
    end
  end

  describe '-@' do
    let(:result) { -v }

    it 'returns the negation' do
      expect(result.arr).to eq([-2,-8,-1])
    end
  end

  describe '+(other)'do
    let(:result) { v + u }

    it 'adds other to self in element-wise' do
      expect(result.arr).to eq([7,4,8])
    end
  end

  describe '-(other)'do
    let(:result) { v - u }

    it 'substract other from self' do
      expect(result.arr).to eq([-3,12,-6])
    end
  end

  describe '*(other)'do
    let(:result) { v * k }

    context 'with a scalar value' do
      it 'multiplies each value by other' do
        expect(result.arr).to eq([4,16,2])
      end
    end

    context 'with another vector' do
      let(:result) { v * u }

      it 'multiplies in element-wise' do
        expect(result.arr).to eq([10,-32,7])
      end
    end
  end

  describe '/(other)'do
    let(:result) { v / k }

    it 'divides each value by other' do
      expect(result.arr).to eq([1,4,0.5])
    end
  end

  describe '#abs'do
    let(:result_abs) { v.abs }
    let(:result_length) { v.length }

    it 'returns its length' do
      expect(result_abs).to eq(Math::sqrt(69))
      expect(result_length).to eq(Math::sqrt(69))
    end
  end

  describe '#inner_prod'do
    let(:result) { v.inner_prod(u) }

    it 'returns the inner product with other' do
      expect(result).to eq(-15)
    end
  end

  describe '#outer_prod'do
    let(:result) { v.outer_prod(u) }

    it 'returns the outer product with other' do
      expect(result.arr).to eq([60,-9,-48])
    end
  end

  describe '#square_length' do
    let(:result) { v.square_length }

    it 'returns the square of the length' do
      expect(result).to eq(69)
    end
  end

end
