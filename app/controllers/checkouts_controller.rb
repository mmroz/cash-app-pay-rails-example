# frozen_string_literal: true
class CheckoutsController < ApplicationController
  before_action :set_checkout, only: %i[show edit update destroy customer_request_callback]

  # GET /checkouts or /checkouts.json
  def index
    @checkouts = Checkout.all
  end

  # GET /checkouts/1 or /checkouts/1.json
  def show
    @customer_request = CashAppPay::CustomerRequest.retrieve(@checkout.customer_request_id)
  end

  # GET /checkouts/new
  def new
    @checkout = Checkout.new
  end

  # GET /checkouts/1/edit
  def edit; end

  # POST /checkouts or /checkouts.json
  def create
    @checkout = Checkout.new(checkout_params)
    respond_to do |format|
      if @checkout.save

        @customer_request = CashAppPay::CustomerRequest.create(customer_request_params(@checkout))
        @checkout.update(customer_request_id: @customer_request.id)

        format.html { redirect_to checkout_url(@checkout), notice: 'Checkout was successfully created.' }
        format.json { render :show, status: :created, location: @checkout }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /checkouts/:id/customer_request_callback
  def customer_request_callback
    debugger
    @customer_request = CashAppPay::CustomerRequest.retrieve(@checkout.customer_request_id)
    render :show
  end

  # PATCH/PUT /checkouts/1 or /checkouts/1.json
  def update
    respond_to do |format|
      if @checkout.update(checkout_params)
        format.html { redirect_to checkout_url(@checkout), notice: 'Checkout was successfully updated.' }
        format.json { render :show, status: :ok, location: @checkout }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checkouts/1 or /checkouts/1.json
  def destroy
    @checkout.destroy!

    respond_to do |format|
      format.html { redirect_to checkouts_url, notice: 'Checkout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
  def set_checkout
    @checkout = Checkout.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
  def checkout_params
    params.require(:checkout).permit(:customer_request_id, :grant_id, :total)
  end

  def customer_request_params(checkout)
    # TODO - update me with the URL
    {
      "idempotency_key": SecureRandom.uuid,
      "actions": [
        {
            "amount": checkout_params[:total]&.to_i&. / 100.0,
            "currency": 'USD',
            "scope_id": 'BRAND_9t4pg7c16v4lukc98bm9jxyse',
            "type": 'ONE_TIME_PAYMENT'
          }
      ],
      "channel": 'IN_PERSON',
      "redirect_url": "http://localhost:3000/checkouts/#{checkout.id}/customer_request_callback"
    }
  end
end
