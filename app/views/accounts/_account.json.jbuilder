json.extract! account, :id, :description, :amount, :member_id, :created_at, :updated_at
json.url account_url(account, format: :json)
