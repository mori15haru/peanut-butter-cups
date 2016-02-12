require 'spec_helper'
require './sphere'
require './ray'

describe Sphere do
  let(:sphere) { Sphere.new(centre) }
  let(:centre) { [50,0,0] }

  describe '#initialize' do
    it 'is blue as default' do
      expect(sphere.colour.arr).to eq([0,0,1])
    end
  end

  describe '#intersect' do
    subject { sphere.intersect(ray) }
    
    let(:ray) { Ray.new(org, dir) }
    let(:org) { Vec.new([0,0,0]) }
    let(:dir) { Vec.new([1,0,0]) }
    
    context 'intersects with the ray' do
      context 'behind the ray' do
        let(:centre) { [-50,0,0] }
        
        it 'returns the infinity' do
          expect(subject).to eq(Float::INFINITY)
        end
      end
      
      context 'infront of the ray' do
        it 'returns the distance' do
          expect(subject).to eq(40)
        end
      end
    end

    context 'does not intersect with the ray' do
      let(:centre) { [50,50,50] }

      it 'returns the infinity' do
        expect(subject).to eq(Float::INFINITY)
      end
    end
  end
end
