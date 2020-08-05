class Item
 attr_reader  :name
  def initialize(item_hash)
    @name = item_hash[:name]
  end

end
