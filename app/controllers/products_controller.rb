class ProductsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_business
    before_action :find_product, only: [:show, :edit, :update, :destroy]
    before_action :find_correct_user, only: [:show, :edit, :update, :destroy]

    def index
        @products = @business.products.includes(:business, :user)
    end

    def show
        
    end

    def new
        @product = Product.new
    end

    def create
        @product = @business.products.build(product_params)
        @product.user = current_user
        if @product.save
            respond_to do |format|
                format.html { redirect_to business_product_path(@business, @product), notice: 'Product successfully created' }
            end
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        
    end

    def update
        if @product .update(product_params)
            respond_to do |format|
                format.html { redirect_to business_product_url(@business, @product), notice: 'Product successfully updated' }
            end
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @product.destroy
        respond_to do |format|
            format.html { redirect_to business_products_url(@business), notice: 'Product deleted!' }
        end
    end

    private

    def product_params
        params.require(:product).permit(:name, :description, :quantity, :unit_price)
    end

    def find_product
      @product ||= Product.find(params[:id])
    end

    def find_business
        @business ||= Business.find(params[:business_id])
    end

    def find_correct_user
        @product ||= Product.find(params[:id])
        redirect_to(businesses_url, status: :see_other, notice: "Access denied, not your product.") unless @product.user == current_user
    end
end
