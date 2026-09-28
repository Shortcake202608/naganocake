class HomesController < ApplicationController
  def top
    @new_items = Item.all.order(created_at: :desc)
  end

  def about
  end
end
