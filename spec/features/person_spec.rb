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

  scenario 'Users can edit people' do
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

    click_on 'Edit'
    fill_in 'Title', :with => 'Dr.'
    fill_in 'First Name', :with => 'Funken'
    fill_in 'Last Name', :with => 'Stein'
    click_on 'Update User'

    within '.table' do
      expect(page).to have_content('Dr. Funken Stein')
    end
  end

  scenario "Users must enter a first name or a title, and must enter a tilte" do
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
    click_on 'Edit'
    fill_in 'Title', :with => ''
    fill_in 'First Name', :with => ''
    fill_in 'Last Name', :with => 'Stein'
    click_on 'Update User'
    expect(page).to have_content('Title or First Name must be entered')
  end

  scenario "Users can assign people to locations" do
    create_location(name: "Northwest")
    create_user email: "user@example.com"
    person = create_person

    visit root_path

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    click_on person.full_name
    click_on "+ Add Location"

    expect(page).to have_content("Assign #{person.full_name} a Location")
    select "Northwest", from: "assignment_location_id"
    fill_in 'Role', :with => 'Boss Man'
    click_on 'Assign'

    within '.page-header' do
      expect(page).to have_content(person.full_name)
    end

    within '.table' do
      expect(page).to have_content("Northwest")
      expect(page).to have_content("Boss Man")
    end

  end

  scenario "People cannot be assigne to the same location with the same role" do
    create_location(name: "Northwest")
    login
    click_on @person.full_name
    click_on "+ Add Location"

    expect(page).to have_content("Assign #{@person.full_name} a Location")
    select "Northwest", from: "assignment_location_id"
    fill_in 'Role', :with => 'Boss Man'
    click_on 'Assign'

    click_on "+ Add Location"

    expect(page).to have_content("Assign #{@person.full_name} a Location")
    select "Northwest", from: "assignment_location_id"
    fill_in 'Role', :with => 'Boss Man'
    click_on 'Assign'

    expect(page).to have_content("You cannot add the same role to the same location")
  end

  scenario "Users can edit assignments" do
    create_location(name: "Northwest")
    create_location(name: "Southwest")
    login

    click_on @person.full_name
    click_on "+ Add Location"

    expect(page).to have_content("Assign #{@person.full_name} a Location")
    select "Northwest", from: "assignment_location_id"
    fill_in 'Role', :with => 'Boss Man'
    click_on 'Assign'

    click_on "edit"

    expect(page).to have_content("Edit #{@person.full_name} a Location")
    select "Southwest", from: "assignment_location_id"
    fill_in 'Role', :with => 'Client'
    click_on 'Update'

    expect(page).to have_content("Client")
    expect(page).to have_content("Southwest")

    expect(page).to have_no_content("Northwest")
    expect(page).to have_no_content("Boss Man")

  end

  scenario "Users can delete assignments" do
    create_location(name: "Northwest")
    create_location(name: "Southwest")
    login

    click_on @person.full_name
    click_on "+ Add Location"

    expect(page).to have_content("Assign #{@person.full_name} a Location")
    select "Northwest", from: "assignment_location_id"
    fill_in 'Role', :with => 'Boss Man'
    click_on 'Assign'

    click_on "Delete"

    expect(page).to have_no_content("Boss Man")
  end


  scenario "Users can see assignment count on home page" do
    create_location(name: "Northwest")
    create_location(name: "Southwest")
    login

    click_on @person.full_name
    click_on "+ Add Location"

    expect(page).to have_content("Assign #{@person.full_name} a Location")
    select "Northwest", from: "assignment_location_id"
    fill_in 'Role', :with => 'Boss Man'
    click_on 'Assign'
    visit root_path
    expect(page).to have_content("1")

    click_on @person.full_name
    click_on "+ Add Location"

    expect(page).to have_content("Assign #{@person.full_name} a Location")
    select "Southwest", from: "assignment_location_id"
    fill_in 'Role', :with => 'Client'
    click_on 'Assign'
    visit root_path
    expect(page).to have_content("2")

  end

end
