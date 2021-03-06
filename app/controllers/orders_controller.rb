require 'order_state_mgr'
require 'order_cost_mgr'

class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]
  before_action :authenticate_user_from_token

  DONE_PREPARING_TIME = 10

  # GET /orders
  def index
    @orders = Order.all

    render json: @orders
  end

  # GET /orders/1
  def show
    if @order.paid_time
      puts "paid_time #{@order.paid_time.localtime}"
      puts "now_time #{Time.now}"
      preparing_time = (Time.now - @order.paid_time.localtime).to_i
      puts "OrdersController.show preparing_time: #{preparing_time}"
      if preparing_time > DONE_PREPARING_TIME
        if OrderStateMgr.instance(self).barista_done_preparing
          @order.update(:status => OrderStateMgr.instance(self).get_state_str)
        end
      end
    end

    links = OrderStateMgr.instance(self).hypermedia

    render json: @order.to_json(links)
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    @order.cost = calculate_cost(@order)
    @order.status = OrderStateMgr.instance(self).payment_expected_state.get_str #init status

    if @order.save
      @payment = Payment.new({:order_id => @order.id})
      if @payment.save
        OrderStateMgr.instance(self).set_curr_state(@order)
        links = OrderStateMgr.instance(self).hypermedia
        render json: @order.to_json(links), status: :created, location: @order
      else
        render status: :internal_server_error
      end
    else
      render status: :bad_request, json: @order.as_json("error" => @order.errors.full_messages[0])
    end
  end

  # PATCH/PUT /orders/1
  def update
    conflict = !OrderStateMgr.instance(self).update_order
    if !conflict
      if @order.update(update_params)
        new_cost = calculate_cost(@order)
        if (new_cost != @order.cost)
          @order.update(:cost => new_cost)
        end

        links = OrderStateMgr.instance(self).hypermedia
        render json: @order.to_json(links)
      else
        render json: @order, status: :conflict
      end
    else
      render json: @order, status: :conflict
    end
  end

  # DELETE /orders/1
  def destroy
    if  OrderStateMgr.instance(self).cancel_order
      @order.destroy
    else
      render status: :method_not_allowed
    end
  end


  def calculate_cost(order)
    OrderCostMgr.instance.set_drink(@order.name)
    OrderCostMgr.instance.set_quantity(@order.quantity)
    OrderCostMgr.instance.set_milk(@order.milk)
    OrderCostMgr.instance.set_size(@order.size)
    OrderCostMgr.instance.set_shots(@order.shots)
    OrderCostMgr.instance.calculate_cost
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
      OrderStateMgr.instance(self).set_curr_state(@order)
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:location, :name, :quantity, :milk, :size, :shots, :user_id)
    end

    def update_params
      params.require(:order).permit(:location, :name, :quantity, :milk, :size, :shots)
    end
end
