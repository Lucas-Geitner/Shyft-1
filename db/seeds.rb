# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
organisations = {
  "McDonald's" => {
    org_postes: ["Cuisine", "Caisse", "McCafe", "Plonge", "Service"],
    photo: "http://media.zenfs.com/en_us/News/Reuters/2014-09-09T150237Z_1972753717_GM1EA991RXB01_RTRMADP_3_US-MCDONALDS-SALES.JPG"
  },
  "Chez Clément" => {
    org_postes: ["Cuisine", "Caisse", "Bar", "Plonge", "Service"],
    photo: "http://www.chezclement.com/images/restaurant-opera-1.jpg"
  },
  "Exki" => {
    org_postes: ["Cuisine", "Caisse", "Bar", "Plonge", "Service"],
    photo: "http://misterjill.be/images/detail/1200_EXKI_01.jpg"
  }
}

postes = Array.new
organisations.each do |org, attributes|
  attributes[:org_postes].each do |poste|
    unless postes.include?(poste)
      postes << poste
    end
  end
end

def choose_weighted(weighted)
  sum = weighted.inject(0) do |sum, item_and_weight|
    sum += item_and_weight[1]
  end
  target = rand(sum)
  weighted.each do |item, weight|
    return item if target <= weight
    target -= weight
  end
end

300.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email("#{first_name}.#{last_name}")
  user = User.new(
    email: email,
    password: "aaaaaaaa",
    phone: Faker::PhoneNumber.cell_phone,
    first_name: first_name,
    last_name: last_name,
    start_date: Faker::Date.between(2.years.ago, Date.today),
    hourly_wage: rand(9.0..20.0).round(2))
  user.save
end

postes.each do |poste|
  Poste.create(name: poste)
end

organisations.each do |org, attributes|
  Organisation.create(
    name: org,
    photo: attributes[:photo])
  attributes[:org_postes].each do |poste|
    OrganisationPoste.create(
      organisation: Organisation.find_by_name(org),
      poste: Poste.find_by_name(poste))
  end
end

30.times do
  opening_time = Time.now.midnight + rand(6..11).hours
  closing_time = opening_time + rand(8..12).hours
  organisation = Organisation.all.sample
  shop = Shop.new(
    name: organisation.name + " " + Faker::Address.city,
    opening_time: opening_time,
    closing_time: closing_time,
    organisation: organisation)
  shop.save
end

User.all.each do |user|
  organisation_membership = OrganisationMembership.new(
    user: user,
    organisation: Organisation.all.sample)
  organisation_membership.save

  membership = Membership.new(
    user: user,
    shop: Shop.all.sample,
    role: choose_weighted({ "HR Manager" => 1, "Line Manager" => 10, "Employee" => 100 }),
    contract_hours: rand(128..156))
  membership.save
end

User.joins(:memberships).where(memberships: {role: "Line Manager"}).each do |manager|
  start_date = Date.today + rand(4).months + rand(30).days
  end_date = start_date + 30.days
  rand(10).times do
    planning = Planning.new(
      start_date: start_date,
      end_date: end_date,
      user: manager,
      shop: manager.memberships.first.shop)
    planning.save
  end
end

Shop.all.each do |shop|
  shop.organisation.postes.each_with_index do |poste, i|
    ShopPoste.create(shop: shop, poste: poste, color: POSTE_COLORS[i])
  end
end

User.joins(:memberships).where(memberships: {role: "Employee"}).each do |employee|
  emp_postes = employee.shops.first.postes
  emp_postes.sample(rand(1..emp_postes.count)).each do |poste|
    Ability.new(user: employee, poste: poste).save
  end

  rand(5).times do
    poste = employee.abilities.all.sample.poste
    shop = employee.memberships.first.shop
    planning = Planning.where(shop: shop).sample

    shift = Shift.new(
      user: employee,
      poste: poste,
      planning: planning,
      starts_at: shop.opening_time + rand(3).hours,
      ends_at: shop.closing_time - rand(3).hours)
    shift.save
  end
end

chaline = User.joins(:memberships, :shops).where(memberships: {role: "Line Manager"}, shops: {organisation: 1}).first
clement = User.joins(:memberships, :shops).where(memberships: {role: "Line Manager"}, shops: {organisation: 2}).first

chaline.update(first_name: "Chaline", last_name: "Itsu-Bitsu", email: "chaline.itsu-bitsu@gmail.com")
clement.update(first_name: "Clément", last_name: "Dubois", email: "clement@gmail.com")
