# frozen_string_literal: true

json.extract! checkout, :id, :customer_request_id, :grant_id, :total, :created_at, :updated_at
json.url checkout_url(checkout, format: :json)
