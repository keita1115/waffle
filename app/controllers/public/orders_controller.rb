class Public::OrdersController < ApplicationController
  
  def new
    @order = Order.new
  end

  def index
    @orders = current_customer.orders.all.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
  end

  def complete
  end

  def confirm
      @order = Order.new(order_params)

  if params[:order][:address_number] == "1"
    @order.name = current_customer.last_name
    @order.address = current_customer.address
    @order.post_number = current_customer.post_number
  elsif params[:order][:address_number] == "2"
    if Address.exists?(params[:order][:address_id])
      @order.name = Address.find(params[:order][:address_id]).name
      @order.address = Address.find(params[:order][:address_id]).address
      @order.post_number = Address.find(params[:order][:address_id]).post_number
    else
      render :new
    end
  elsif params[:order][:address_number] == "3"
    address_new = current_customer.addresses.new(address_params)
    if address_new.save 
    else
      render :new
    end
  else
    redirect_to order_order_confirm_path(current_customer)
  end
    @cart_items = current_customer.cart_items.all
  end

 
def create 
  cart_items = current_customer.cart_items.all
  @order = current_customer.orders.new(order_params)
  @order.customer_id = current_customer.id
  if @order.save
    cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.order_id = @order.id
      order_detail.item_id = cart_item.item_id
      order_detail.price = cart_item.item.with_tax_price
      order_detail.quantity = cart_item.quantity
      order_detail.save
    end
    redirect_to order_orders_complete_path(current_customer)
    cart_items.destroy_all
  else
    @order = Order.new(order_params)
    render :new
  end
end

  private

  def order_params
    params.require(:order).permit(:payment_method, :post_number, :address, :name, :item_id, :total_payment)
  end
  
  def address_params
    params.require(:order).permit(:name, :address,:post_number)
  end
end
