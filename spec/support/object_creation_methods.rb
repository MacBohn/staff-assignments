def create_user(overrides = {})
  User.create!({
    name: 'Some User',
    email: 'user@example.com',
    password: 'password',
    password_confirmation: 'password'
  }.merge(overrides))
end

def create_person(overrides = {})
  Person.create!({
    title: Faker::Name.prefix,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
  }.merge(overrides))
end
