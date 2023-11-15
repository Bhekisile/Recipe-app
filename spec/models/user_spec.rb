require 'rails_helper'

RSpec.describe 'User', type: :request do
  let(:user) { User.create(name: 'Arnold') }

  it 'has many recipes' do
    association = User.reflect_on_association(:recipes)
    expect(association.macro).to eq :has_many
  end

  it 'has many foods' do
    association = User.reflect_on_association(:foods)
    expect(association.macro).to eq :has_many
  end

  describe 'Validations' do
    it 'name should be present' do
      user.name = nil
      expect(user).to_not be_valid
    end
  end
end
