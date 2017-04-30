json.extract! transaction, :id, :member_id, :kind_transaction_id, :description, :amount, :date, :category_id, :account_id, :paid, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
