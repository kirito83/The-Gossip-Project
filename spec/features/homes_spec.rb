require 'rails_helper'
require 'rails_helper'

RSpec.feature "Homes", type: :feature do
	context 'Integration' do
		it 'should return signup if there is no current user' do
			visit root_path
			expect(page).to have_content('Hey bro connecte-toi')
		end

		it 'should return gossips if there is a current user' do
			visit new_moussaillon_registration_path

			fill_in 'moussaillon_username', :with => 'MyUsername'
			fill_in 'moussaillon_email', :with => 'MyEmail@example.com'
			fill_in 'moussaillon_password', :with => 'MyPassword'
			fill_in 'moussaillon_password_confirmation', :with => 'MyPassword'
			fill_in 'moussaillon_sign_up_code', :with => 'GOSSIP_2018'
			click_button "S'enregistrer"

			visit root_path
			expect(page).to have_content('Liste des gossips')
		end
	end
end