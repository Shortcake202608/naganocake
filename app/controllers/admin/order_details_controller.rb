class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order

    if @order_detail.update(order_detail_params)

      # ② 製作ステータスが1つでも「製作中」なら注文ステータスを「製作中」に
      if @order.order_details.any? { |detail| detail.making_status == "making" }
        @order.update(status: "in_production")
      end

      # ③ 全て「製作完了」なら注文ステータスを「発送準備中」に
      if @order.order_details.all? { |detail| detail.making_status == "finished" }
        @order.update(status: "preparing_shipment")
      end

      flash[:notice] = "製作ステータスを更新しました"
      redirect_to admin_order_path(@order)
    else
      flash[:alert] = "更新に失敗しました"
      redirect_to admin_order_path(@order)
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
