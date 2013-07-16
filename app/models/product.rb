class Product < ActiveRecord::Base
  attr_accessible :description, :price, :title, :assets_attributes ,:asset
  
  has_many :assets
  accepts_nested_attributes_for :assets, :allow_destroy => true
  
  default_scope :order => 'title'
  has_many :line_items
  has_many :orders, :through => :line_items
  
  before_destroy :ensure_not_referenced_by_any_line_item
  
  validates :title, :description, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
    
  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors.add(:base, 'Line Items present' )
      return false
    end
  end
end
