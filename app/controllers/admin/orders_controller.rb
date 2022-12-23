class Admin::OrdersController < ApplicationController
  
  def index
    @orders = Order.all.page(params[:page]).per(10)
  end

  def create
    @order = Order.new(order_params)
    @order.save
  end

  def new
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params) && @order.order_status == "confirm_payment"
       flash[:notice] = "注文ステータス更新"
       @order.order_details.update_all(making_status: 1)
       redirect_to admin_order_path(@order.id)
    else
       redirect_to admin_order_path(@order.id)
    end
  end



  private
    def order_params
      params.require(:order).permit(:customer_id, :post_number, :address, :name, :shipping_cost, :total_payment, :payment_method, :order_status, :amount)
    end
    
end
