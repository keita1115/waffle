class Public::ItemsController < ApplicationController

  def index
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.page(params[:page]).per(6)
    else
      @items = Item.all.page(params[:page]).per(6)
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end


  private
    def item_params
      params.require(:item).permit(:genre_id, :name, :item_image, :introduction, :price, :is_active)
    end

end
