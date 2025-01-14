class Item < ApplicationRecord

  validates :purchaser_name, 
            :item_description, 
            :gross_income,
            :item_price, 
            :purchase_count, 
            :merchant_address, 
            :merchant_name,
            :user_id,
             presence: true
  
end
