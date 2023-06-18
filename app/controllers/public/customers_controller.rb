class Public::CustomersController < ApplicationController

  def show
    @customer = Customer.find(current_customer.id)
  end

  def unsubscribe
  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.is_deleted = true
    @customer.save
    reset_session
    flash[:notice] = "退会が完了しました。"
    redirect_to root_path
  end

end
