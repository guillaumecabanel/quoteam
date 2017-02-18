require 'rails_helper'

RSpec.describe Team, type: :model do
  subject(:team) { Team.new }

  describe "validations" do
    it 'requires presence of a name' do
      team.name = nil
      team.valid?
      expect(team.errors[:name]).not_to be_empty
    end
  end

end
