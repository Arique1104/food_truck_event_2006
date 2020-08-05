require "date"
class Event
 attr_reader  :name,
              :food_trucks
  def initialize(name)
    @name = name
    @food_trucks = []
    @date = Time.new
  end

  def date
    @date.strftime("%m/%d/%Y")
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map do |food_truck|
      food_truck.name
    end
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all do |food_truck|
      food_truck.inventory[item] != 0
    end
  end

  def total_inventory
    inventory_hash = Hash.new {|h,k| h[k] = {quantity: 0, food_trucks: []}}
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |item, quantity|
        inventory_hash[item][:quantity] += quantity
        inventory_hash[item][:food_trucks] << food_truck if quantity != 0
      end
    end
    inventory_hash
  end

  def overstocked_items
    result = total_inventory.find_all do |item, inventory_hash|
      if inventory_hash[:quantity] > 50 && inventory_hash[:food_trucks].count > 1
        item
      end
    end
    result.map do |item, inventory_hash|
      item
    end
  end

  def sorted_item_list
    total_inventory.keys.map do |item|
      item.name
    end.sort.uniq
  end

  def sell(item, quantity)
    total_to_sell = quantity
    total = total_inventory[item][:quantity]
    if total >= quantity
      food_trucks = food_trucks_that_sell(item)
      food_trucks.map do |food_truck|
        food_truck_amount = food_truck.inventory[item]
        if total_to_sell >= food_truck_amount
          total_to_sell - food_truck_amount
          food_truck.inventory[item] = 0
        else total_to_sell <= food_truck_amount
          food_truck_amount - total_to_sell
          food_truck.inventory[item] = food_truck_amount - total_to_sell
        end
      end
      true
    else
      false
    end
  end

end
