class Cart < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :line_items, :dependent => :destroy
  
  # A smart add_product. Checks whether the product 
  #
  # we are adding exists in the cart
  #
  # if it exists it increments Quantity if it doesn't 
  #
  # exist it creates a new Item.
  def add_product(product_id)
    current_item = line_items.where(:product_id => product_id).first
  
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(:product_id => product_id)
    end
    
    current_item
  end
  
  #Gets the total number of items in the Cart.
  def total_items
    line_items.sum(:quantity)
  end
  
  #Calculate the total price of all items in the Cart.
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
