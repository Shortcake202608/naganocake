class CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
  end

  def create
    existing_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    if existing_item
      existing_item.amount += params[:cart_item][:amount].to_i
      if existing_item.save
        redirect_to cart_items_path, notice: "商品数量を更新しました"
      else
        redirect_back fallback_location: item_path(existing_item.item_id), alert: "数量変更に失敗しました"
      end
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      if @cart_item.save
        redirect_to cart_items_path, notice: "商品をカートに追加しました"
      else
        redirect_back fallback_location: item_path(@cart_item.item_id), alert: "カート追加に失敗しました"
      end
    end
  end

  def update
    @cart_item = current_customer.cart_items.find(params[:id])

    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path, notice: "数量を変更しました"
    else
      redirect_to cart_items_path, alert: "変更できませんでした"
    end
  end

  def destroy
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path, notice: "商品を削除しました"
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path, notice: "カート内の商品を全て削除しました"
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
