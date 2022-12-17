class Admin::OrderDetailsController < ApplicationController
  
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_details_params)
    @order = @order_detail.order

    if @order_detail.making_status == "making"
      @order.update(order_status: 2)
      redirect_to admin_order_path(@order.id)
    elsif @order.order_details.count == @order.order_details.where(making_status: "complete").count

      @order.update(order_status: 3)
      redirect_to admin_order_path(@order.id)
    else
      redirect_to admin_order_path(@order.id)
    end
  end


  private
    def order_details_params
      params.require(:order_detail).permit(:order_id, :item_id, :price, :quantity, :making_status)
    end

end
