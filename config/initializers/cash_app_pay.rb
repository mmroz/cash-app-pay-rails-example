# frozen_string_literal: true

Rails.configuration.cash_app_pay = {
  client_id: 'CAS-CI_PAYKIT_MOBILE_DEMO',
  api_base: CashAppPay::Endpoint::SANDBOX
}

CashAppPay.client_id = Rails.configuration.cash_app_pay[:client_id]
CashAppPay.api_base = Rails.configuration.cash_app_pay[:api_base]
