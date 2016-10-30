class PaymentsController < ApplicationController
  #before_action :set_payment, only: [:show, :update, :destroy]
  before_action :authenticate_user_from_token

  # GET /payments
  def index
    @payments = Payment.all

    render json: @payments
  end

  # GET /payments/1
  def show
    @payment = Payment.find_by(order_id: params[:id])
    render json: @payment
  end

  # POST /payments
  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      render json: @payment, status: :created, location: @payment
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payments/1
  def update
    @payment = Payment.find_by(order_id: params[:id])
    @order = Order.find(params[:id])
    if ((params[:amount]).to_f != @order.cost)
      render status: :method_not_allowed, json: @payment
    else
      OrderStateMgr.instance(self).set_curr_state(@order)
      if OrderStateMgr.instance(self).payment
        if @payment.update(payment_params) and @order.update({:status => OrderStateMgr.instance(self).get_state_str})
          links = OrderStateMgr.instance(self).hypermedia
          render json: @order.to_json(links)
        else
          render status: :bad_request, json: @payment.as_json("error" => @payment.errors.full_messages[0])
        end
      else
        render json: @payment, status: :conflict
      end
    end
  end

  # DELETE /payments/1
  def destroy
    @payment = Payment.find_by(order_id: params[:id])
    @payment.destroy
  end

  private

    # Only allow a trusted parameter "white list" through.
    def payment_params
      params.require(:payment).permit(:card_holder_name, :card_number, :expiry_month, :expiry_year, :amount)
    end
end
