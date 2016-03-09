# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
organisations = ["McDonald's", "Quick", "Exki"]
postes = {
  Cuisine: "#ffb444",
  Caisse: "#3772ff",
  McCafe: "#e44545",
  Plonge: "#a56fd6",
  Service: "#2bda62"
}

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
    last_name: last_name)
  user.save
end

organisations.each do |org|
  Organisation.new(name: org).save
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

postes.each do |poste, color|
  Poste.new(name: poste, color: color).save
end

User.all.each do |user|
  organisation_membership = OrganisationMembership.new(
    user: user,
    organisation: Organisation.all.sample)
  organisation_membership.save

  membership = Membership.new(
    user: user,
    shop: Shop.all.sample,
    role: choose_weighted({ "HR Manager" => 1, "Line Manager" => 10, "Employee" => 100 }))
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

Organisation.all.each do |org|
  Poste.all.each do |poste|
    Orgposte.create(organisation: org, poste: poste)
  end
end

Shop.all.each do |shop|
  shop.organisation.postes.each do |poste|
    Shpposte.create(shop: shop, poste: poste)
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

Membership.where(role: "Line Manager").first.user.update(first_name: "Chaline", last_name: "Itsu-Bitsu", email: "chaline.itsu-bitsu@gmail.com")
