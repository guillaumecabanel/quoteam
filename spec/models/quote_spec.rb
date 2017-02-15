require 'rails_helper'

RSpec.describe Quote, type: :model do
  subject(:quote) { Quote.new }

  describe "validations" do
    it 'requires presence of a content' do
      quote.content = nil
      quote.valid?
      expect(quote.errors[:content]).not_to be_empty
    end

    it 'requires presence of an author' do
      quote.author = nil
      quote.valid?
      expect(quote.errors[:author]).not_to be_empty
    end
  end

end
