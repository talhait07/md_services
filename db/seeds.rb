# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if ENV['SEED_ENV'] == 'development'
  application = Doorkeeper::Application.create(name: 'Browser', redirect_uri: 'https://scrubpay-staging.herokuapp.com')
  application.update_attributes!(uid: '385b8167e77653d443e31c17df3cbe39ea784f36fd3423a7b55783a8d23aac07', secret: '36cf2b6786093842b50f38bbd1464b4d944ef1672cb94612d4d39b256e5a2d35')

  admin = User.create(first_name: 'ScrubPay', last_name: 'Admin', email: 'admin@scrubpay.com', password: 'password', god: true)

  user = User.create(first_name: 'Biff', last_name: 'Imbierowicz', email: 'biff@sticksnleaves.com', password: 'password')
  organization = Organization.create(name: 'Imbierowicz Medical Group', npi_number: 'x2224fdsfsd', positions: 5, address_1: '1235 North St.', city: 'Kokomo', state: 'IN', postal_code: '46901', phone_number: '5555555555', url: 'http://imbierowiczmg.com')
  organization_user = OrganizationUser.create(organization: organization, user: user, roles: { admin: true })

  site = organization.sites.create(name: 'Imbierowicz Rehabilitation', address_1: '1234 Main St.', city: 'Kokomo', state: 'IN', postal_code: '46901', phone_number: '4442221111')

  user = User.create(first_name: 'Anthony', last_name: 'Smith', email: 'anthony@sticksnleaves.com', password: 'password')
  organization = Organization.create(name: 'Smith & Smith Medical', npi_number: 'y232cj34', positions: 2, address_1: '814 Elizabeth St.', city: 'Kokomo', state: 'IN', postal_code: '46902', phone_number: '5555555555', url: 'http://ssmedical.com')
  organization_user = OrganizationUser.create(organization: organization, user: user, roles: { admin: true })

  site = organization.sites.create(name: 'Smith & Smith Howard Hospital', address_1: '904 Main St.', city: 'Kokomo', state: 'IN', postal_code: '46902', phone_number: '4442220000')

  user = User.create(first_name: 'Yaw', last_name: 'Aning', email: 'yaw@sticksnleaves.com', password: 'password')
  organization = Organization.create(name: 'Quickngo Medical', npi_number: 'g987de224a', positions: 8, address_1: '606 W. Hoffer St.', city: 'Kokomo', state: 'IN', postal_code: '46902', phone_number: '4445556666', url: 'http://quickngomeds.com')
  organization_user = OrganizationUser.create(organization: organization, user: user, roles: { admin: true })

  site = organization.sites.create(name: 'Medical Express', address_1: '606 W. Hoffer St.', city: 'Kokomo', state: 'IN', postal_code: '46902', phone_number: '4442224343')


  user = User.create(first_name: 'John', last_name: 'Jonas', email: 'jj@scrubpay.com', password: 'password')
  organization = Organization.create(name: 'New York Medngo', npi_number: 'ecq1213122', positions: 120, address_1: '1232 E. Washington St.', city: 'New York', state: 'NY', postal_code: '422422', phone_number: '3332224444', url: 'http://nymedngo.com')
  organization_user = OrganizationUser.create(organization: organization, user: user, roles: { admin: true })

  site = organization.sites.create(name: 'Medngo Firehouse', address_1: '1232 E. Washington St.', city: 'New York', state: 'NY', postal_code: '422422', phone_number: '3332224444')

  patient_list = [
    { first_name: 'Peter', last_name: 'Venkman' },
    { first_name: 'Egon', last_name: 'Spengler' },
    { first_name: 'Raymond', last_name: 'Stantz'},
    { first_name: 'Dana', last_name: 'Barret' },
    { first_name: 'Winston', last_name: 'Zeddmore' },
    { first_name: 'Louis', last_name: 'Tully' },
    { first_name: 'Janine', last_name: 'Melnitz' },
    { first_name: 'Walter', last_name: 'Peck' },
    { first_name: 'Van', last_name: 'Hoffman' },
    { first_name: 'Ted', last_name: 'Fleming' }
  ]

  patient_list.each do |patient|
    first_name   = patient[:first_name]
    last_name    = patient[:last_name]
    birth_date   = rand(1..10000).days.ago.to_date
    phone_number = rand(2000000000..9999999999).to_s

    user = User.create(first_name: first_name, last_name: last_name, email: "#{first_name.downcase}@scrubpay.com", password: 'password')
    profile = Profile.create(user: user, birth_date: birth_date, phone_number: phone_number)
    patient = user.patients.create(site: site)

    rand(0..5).times do |i|
      encounter = site.encounters.create!(first_name: first_name, last_name: last_name, birth_date: birth_date, phone_number: phone_number, balance: rand(40..4000), patient: patient)
    end
  end

end
