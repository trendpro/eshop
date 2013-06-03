class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :product #stupid hack....fix it
  
  belongs_to :order
  belongs_to :product
  belongs_to :cart
  
  #Calculate total price of all items in the line.
  def total_price
    product.price * quantity
  end
end
