
def login
  create_user email: "user@example.com"
  @person = create_person

  visit root_path
  click_on "Login"

  fill_in "Email", with: "user@example.com"
  fill_in "Password", with: "password"
  click_on "Login"
end
