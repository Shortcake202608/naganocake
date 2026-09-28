class Admin::OrdersController < Admin::ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)

      # ① 入金確認 → 製作待ちに自動変更
      if @order.status == "payment_confirm"
        @order.order_details.each do |detail|
          detail.update(making_status: "waiting")
        end
      end

      flash[:notice] = "注文ステータスを更新しました"
      redirect_to admin_order_path(@order)
    else
      flash[:alert] = "更新に失敗しました"
      render :show
    end
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end
end
