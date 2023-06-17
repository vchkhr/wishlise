json.extract! item, :id, :wishlist_id, :title, :url, :price, :description, :created_at, :updated_at
json.url item_url(item, format: :json)
