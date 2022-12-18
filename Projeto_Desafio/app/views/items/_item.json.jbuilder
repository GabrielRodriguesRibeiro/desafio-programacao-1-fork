json.extract! item, :id, :purchaser_name, :item_description, :item_price, :purchase_count, :merchant_address, :merchant_name, :arquivo, :created_at, :updated_at
json.url item_url(item, format: :json)
