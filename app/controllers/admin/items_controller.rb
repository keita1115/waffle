class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_item_path(@item.id)
  end

  def destroy
    @items = Item.all
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_items_path(@item.id)

  end

  private
  
  def item_params
    params.require(:item).permit(:genre_id, :name, :item_image, :introduction, :price, :is_active)
  end

end
