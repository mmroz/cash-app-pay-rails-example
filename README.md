# cash-app-pay-rails-example

Add the Cash App Pay gem the `Gemfile`

```
gem 'cash_app_pay' && bundle
```

Make the file

`config/initializers/cash_app_pay.rb`

Write the following:

```ruby
Rails.configuration.cash_app_pay = {
  client_id: 'REPLACE_ME_WITH_YOUR_CLIENT_ID'
}

CashAppPay.client_id = Rails.configuration.cash_app_pay[:client_id]
```

You are ready create Cash App Pay `CustomerRequests` as follows:

```ruby
customer_request = CashAppPay::CustomerRequest.create(
     {
      "idempotency_key": SecureRandom.uuid,
      "actions": [
        {
            "amount": 10000,
            "currency": 'USD',
            "scope_id": REPLACE_ME_WITH_YOUR_BRAND_ID,
            "type": 'ONE_TIME_PAYMENT'
          }
      ],
      "channel": 'IN_PERSON',
      "redirect_url": REPLACE_ME_WITH_YOUR_REDIRECT_URL
    }
)

customer_request.auth_flow_triggers.qr_code_svg_url
```

Render the HTML

```
<%= image_tag @customer_request.auth_flow_triggers.qr_code_svg_url, height: 300 , width: 400 %>

```
