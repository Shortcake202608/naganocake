class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def search
    @items = Item.where("name LIKE ?", "%#{params[:keyword]}%")
  end
end
