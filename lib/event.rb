class Event
 attr_reader  :name,
              :food_trucks
  def initialize(name)
    @name = name
    @food_trucks = []
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

end
