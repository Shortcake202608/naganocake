class Admin::HomesController < Admin::ApplicationController
  def top
    @orders = Order.all
  end
end
