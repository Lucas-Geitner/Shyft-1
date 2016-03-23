module PostesHelper
  def poste_logo(poste)
    case poste.name
    when "Cuisine" then 'https://maxcdn.icons8.com/Color/PNG/96/Food/hamburger-96.png'
    when "Caisse" then 'https://maxcdn.icons8.com/Color/PNG/96/Ecommerce/check-96.png'
    when "Plonge" then 'https://maxcdn.icons8.com/Color/PNG/96/Household/broom-96.png'
    when "McCafe" then 'https://maxcdn.icons8.com/Color/PNG/96/Food/coffee_to_go-96.png'
    when "Bar" then 'https://maxcdn.icons8.com/Color/PNG/96/Food/coffee_to_go-96.png'
    when "Service" then 'https://maxcdn.icons8.com/Color/PNG/96/Food/waiter-96.png'
    else 'https://maxcdn.icons8.com/Color/PNG/96/City/restaurant-96.png'
    end
  end
end
