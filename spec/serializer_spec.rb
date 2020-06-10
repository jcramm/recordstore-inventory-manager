# frozen_string_literal: true

require './lib/imports/serializer'

describe Imports::Serializer do
  context '.for' do
    it 'returns an instance of CsvSerializer when provided with the type .csv' do
      expect(Imports::Serializer.for('.csv')).to be_an Imports::CsvSerializer
    end

    it 'returns an instance of PipeSerializer when provided with the type .pipe' do
      expect(Imports::Serializer.for('.pipe')).to be_an Imports::PipeSerializer
    end

    it 'raises an error when provided with an invalid type' do
      expect { Imports::Serializer.for('chewbaca') }.to raise_error
    end
  end
end
