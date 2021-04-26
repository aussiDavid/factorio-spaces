# frozen_string_literal: true

require './lib/spaces'

RSpec.describe Spaces do
  context 'when the actual is empty' do
    it { expect(described_class.call({})).to eq({}) }
  end

  context 'when the actual is missing' do
    it { expect(described_class.call(nil)).to eq({}) }
  end

  context 'when the executed with no arguments' do
    it { expect(described_class.call).to eq({}) }
  end

  context 'when the actual contains no items' do
    let(:actual) do
      {
        name: 'iron-ore',
        items: []
      }
    end

    let(:expected) do
      {
        name: 'iron-ore',
        items: [],
        width: 1,
        height: 1
      }
    end

    it { expect(described_class.call(actual)).to eq(expected) }
  end

  context 'when the actual contains 1 item' do
    let(:actual) do
      {
        name: 'iron-plate',
        items: [
          {
            name: 'iron-ore',
            items: []
          }
        ]
      }
    end

    let(:expected) do
      {
        name: 'iron-plate',
        width: 5,
        height: 3,
        items: [
          {
            name: 'iron-ore',
            items: [],
            height: 1,
            width: 1
          }
        ]
      }
    end

    it { expect(described_class.call(actual)).to eq(expected) }
  end
end
