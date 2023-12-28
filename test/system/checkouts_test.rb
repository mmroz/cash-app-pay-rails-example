# frozen_string_literal: true

require 'application_system_test_case'

class CheckoutsTest < ApplicationSystemTestCase
  setup do
    @checkout = checkouts(:one)
  end

  test 'visiting the index' do
    visit checkouts_url
    assert_selector 'h1', text: 'Checkouts'
  end

  test 'should create checkout' do
    visit checkouts_url
    click_on 'New checkout'

    fill_in 'Customer request', with: @checkout.customer_request_id
    fill_in 'Grant', with: @checkout.grant_id
    fill_in 'Total', with: @checkout.total
    click_on 'Create Checkout'

    assert_text 'Checkout was successfully created'
    click_on 'Back'
  end

  test 'should update Checkout' do
    visit checkout_url(@checkout)
    click_on 'Edit this checkout', match: :first

    fill_in 'Customer request', with: @checkout.customer_request_id
    fill_in 'Grant', with: @checkout.grant_id
    fill_in 'Total', with: @checkout.total
    click_on 'Update Checkout'

    assert_text 'Checkout was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Checkout' do
    visit checkout_url(@checkout)
    click_on 'Destroy this checkout', match: :first

    assert_text 'Checkout was successfully destroyed'
  end
end
