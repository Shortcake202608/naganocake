class OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @total = @cart_items.sum { |ci| ci.item.price_with_tax * ci.amount }
    @order.shipping_cost = 800
    @order.total_payment = @total + @order.shipping_cost

    case params[:order][:select_address]
    when "own"  # ← フォームと一致させる
      @order.postal_code = current_customer.postal_code
      @order.address     = current_customer.address
      @order.name        = @order.name = "#{current_customer.last_name} #{current_customer.first_name}"


    when "registered"
      address = Address.find(params[:order][:address_id])
      @order.postal_code = address.postal_code
      @order.address     = address.address
      @order.name        = address.name

    when "new"
      # order_params の値をそのまま使う
    end
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.shipping_cost = 800
    @order.total_payment = params[:order][:total_payment]

    if @order.save
      current_customer.cart_items.each do |cart_item|
        OrderDetail.create(
          order_id: @order.id,
          item_id: cart_item.item_id,
          amount: cart_item.amount,
          price: cart_item.item.price_with_tax
        )
      end
      current_customer.cart_items.destroy_all
      redirect_to complete_orders_path
    else
      @addresses = current_customer.addresses
      render :new
    end
  end



  def complete
  end

  def index
    @orders = current_customer.orders.order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(
      :payment_method,
      :postal_code,
      :address,
      :name,
      :total_payment,
      :shipping_cost,
    )
  end

end
