class Admin::HomesController < Admin::ApplicationController
  def top
    @orders = Order.order(created_at: :desc)
  end
end
