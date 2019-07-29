require 'rails_helper'

RSpec.describe Scraper do
  describe '#bark' do
    subject { Dog.new }
    
    it 'returns the wolf' do
      expect(subject.bark).to eql('Woof')
    end
  end
end
