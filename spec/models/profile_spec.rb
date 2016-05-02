require 'rails_helper'

RSpec.describe Profile, type: :model do

  context 'attributes' do
    it { should respond_to(:name) }
    it { should respond_to(:bio) }
    it { should respond_to(:dob) }
    it { should respond_to(:location) }
    it { should respond_to(:protected) }
  end

  context 'validations' do

  end

  context 'associations' do
    it { should belong_to(:user) }
  end

  context 'scopes' do

  end

  context 'callbacks' do

  end

  context 'methods' do

  end

end
