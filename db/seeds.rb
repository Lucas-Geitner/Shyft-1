# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
organisations = ["McDonald's", "Quick", "Exki"]
postes = %w(Kitchen Cashier Bar Dishwash)

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
  user = User.new(
    email: Faker::Internet.email,
    password: "aaaaaaaa",
    first_name: Faker::Name.first_name,
    last_name:Faker::Name.last_name)
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

postes.each do |poste|
  Poste.new(name: poste).save
end

User.all.each do |user|
  organisation_membership = OrganisationMembership.new(
    user: user,
    organisation: Organisation.all.sample)
  organisation_membership.save

  membership = Membership.new(
    user: user,
    shop: Shop.all.sample,
    role: choose_weighted({ hr_manager: 1, line_manager: 10, basic_employee: 100 }))
  membership.save
end

User.joins(:memberships).where(memberships: {role: :line_manager}).each do |manager|
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

User.joins(:memberships).where(memberships: {role: :basic_employee}).each do |employee|
  Poste.all.sample(rand(1..Poste.count)).each do |poste|
    Ability.new(user: employee, poste: poste).save
  end

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


