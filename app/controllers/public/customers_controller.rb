class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to customers_mypage_path
  end

  def withdrawal
    @customer = current_customer
    @customer.update(is_valid: false)
    reset_session
    flash[:notice] = "退会処理を行いました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :post_number, :address, :phone_number)
  end
  
end
