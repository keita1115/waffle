class Public::HomesController < ApplicationController
  def top
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.page(params[:page]).per(3)
    else
      @items = Item.all.page(params[:page]).per(3)
    end
    @genres = Genre.all
  end
  
end
