class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response



  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
      render json: items
    else
      items = Item.all
      render json: items, include: :user  
    end
    
  end

  def show
    user = User.find(params[:user_id])
    items = user.items.find(params[:id])
    render json: items
  end

  def create
    user = User.find(params[:user_id])
    item = user.items.create(item_params)
    render json: item, status: :created

  end

  private

  def item_params
    params.permit(:name, :description, :price)
  end

  def render_not_found_response
    render json: {error: "User not found"}, status: :not_found
  end


end
