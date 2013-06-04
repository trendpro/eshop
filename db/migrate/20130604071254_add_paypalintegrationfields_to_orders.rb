class AddPaypalintegrationfieldsToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :ip_address, :string
    add_column :orders, :card_type, :string
    add_column :orders, :card_expires_on, :date
  end
  
  def self.down
    remove_column :orders, :ip_address, :string
    remove_column :orders, :card_type, :string
    remove_column :orders, :card_expires_on, :date
  end
end
