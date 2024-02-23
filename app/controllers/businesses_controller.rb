class BusinessesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_business, only: [:show, :edit, :update, :destroy]
  before_action :find_correct_user, only: [:show, :edit, :update, :destroy]

  def index
    @businesses = current_user.businesses.ordered
  end

  def show
    
  end

  def new
    @business = Business.new
  end

  def create
    @business = current_user.businesses.build(business_params)
    if @business.save
      respond_to do |format|
        format.html { redirect_to @business, notice: 'Your business has been successfully created' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    
  end

  def update
    if @business.update(business_params)
      respond_to do |format|
        format.html { redirect_to @business, notice: 'Your business has been successfully updated' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @business.destroy
    respond_to do |format|
      format.html { redirect_to businesses_url, notice: 'Business deleted!' }
    end
  end

  private

  def business_params
    params.require(:business).permit(:name, :description, :business_code, :category_id)
  end

  def find_business
    @business ||= Business.find(params[:id])
  end

  def find_correct_user
    @business ||= Business.find(params[:id])
    redirect_to(businesses_url, status: :see_other, notice: "Access denied, not your business.") unless @business.user == current_user
  end
end
