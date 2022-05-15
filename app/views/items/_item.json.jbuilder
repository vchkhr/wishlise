json.extract! item, :id, :list_id, :title, :description, :url, :image_url, :price, :created_at, :updated_at
json.url item_url(item, format: :json)
