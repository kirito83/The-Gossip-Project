require 'rails_helper'

RSpec.describe Moussaillon, type: :model do
  context 'sign up code' do
  	it 'should create with the good code' do
  		m = build(:moussaillon)
  		expect(m.valid?).to be(true)
  	end

  	it "shouldn't create with a wrong code" do
  		m = build(:moussaillon_wrong_code)
  		expect(m.valid?).to be(false)
  	end
  end
end
