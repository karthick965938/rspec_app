require 'rails_helper'

RSpec.feature "Homes", type: :feature do

	scenario "the home page see karthick text" do
		visit home_index_path
		expect(page).to have_text('Email')
	end
end
