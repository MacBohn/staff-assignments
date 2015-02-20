require 'rails_helper'
require 'capybara/rails'

feature 'Person -' do

  scenario 'Users can see a person show page' do
    create_user email: "user@example.com"
    person = create_person

    visit root_path
    click_on "Login"

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    click_on person.full_name
    within 'h1' do
      expect(page).to have_content(person.full_name)
    end
  end

end
