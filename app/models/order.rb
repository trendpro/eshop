class Order < ActiveRecord::Base
  attr_accessible :address, :email, :name, :ip_address, :card_type, :card_expires_on,
                  :card_number, :card_verification
  attr_accessor   :card_number, :card_verification
  
  validate :validate_card, :on => :create
  
  has_many :line_items, :dependent => :destroy
  has_many :transactions, :class_name => "OrderTransaction"
  
  PAYMENT_TYPES = [ "Check" , "Credit card" , "Purchase order" ]
  
  validates :name, :address, :email, :presence => true
  
  #Adds a Line item to an order from Cart.
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
  
  def purchase
    response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
    transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
    #cart.update_attribute(:purchased_at, Time.now) if response.success?
    response.success?
  end
  
  #Debug this later...
  def price_in_cents
    10000
  end
  
  private
  
  #Sets thePurchase Options required by PayPal
  def purchase_options
    {
      :ip => ip_address,
      :billing_address => {
        :name     => "Admin Amir",
        :address1 => "123 Main St.",
        :city     => "New York",
        :state    => "NY",
        :country  => "US",
        :zip      => "10001"
      }
    }
  end
  
  #Validates a Credit Card.
  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors[:base] << message
      end
    end
  end
  
  #Creates a Credit Card object from ActiveMerchant.
  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :type               => card_type,
      :number             => card_number,
      :verification_value => card_verification,
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      :first_name         => 'Gideon', #Fix this
      :last_name          => 'Kyalo'  #Fix this later.
    )
  end
end
