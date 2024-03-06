class ProductItemsController < ApplicationController
    before_action :set_customer
    before_action :set_product_item_date
    # before_action :set_products
    before_action :set_product_item, only: [:edit, :update, :destroy]
  
    def new
      @product_item = @product_item_date.product_items.build
      @product_item.payments.build
      # @products = Product.all.map{ |p| [p.name, p.id] }
    end
  
    def create
      @product_item = @product_item_date.product_items.build(product_item_params)
      @product_item.user = current_user
  
      if @product_item.save

        # Decrement the quantity of the product purchased
        @product_item.update_product_quantity

        respond_to do |format|
          format.html { redirect_to customer_path(@customer), notice: "Item was successfully created." }
        #   format.turbo_stream { flash.now[:notice] = "Item was successfully created." }
        end
      else
        render :new
      end
    end

    def edit
      # @products = Product.all
      @product_item.payments.build
    end
  
    def update
      @product_item.user = current_user

      # old_quantity = @product_item.quantity

      if @product_item.update(product_item_params)

        respond_to do |format|
          format.html { redirect_to customer_path(@customer), notice: "Item was successfully updated." }
        #   format.turbo_stream { flash.now[:notice] = "Item was successfully updated." }
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @product_item.destroy

      respond_to do |format|
        format.html { redirect_to customer_path(@customer), notice: "Date was successfully destroyed." }
        # format.turbo_stream { flash.now[:notice] = "Date was successfully destroyed." }
      end
    end
  
    private
    
    def product_item_params
      params.require(:product_item).permit(:name, :description, :quantity, :unit_price, :payment_status)
    end

    # def decrement_quantity(old_quantity)
    #   if @product_item.quantity != old_quantity
    #     @product_item.update_product_quantity
    #   end
    # end
  
    def set_product_item
        @product_item ||= @product_item_date.product_items.find(params[:id])
    end
  
    def set_customer
      @customer ||= Customer.find(params[:customer_id])
    end
  
    def set_business
      @business ||= Business.find(params[:customer_id])
    end
  
    def set_product_item_date
      @product_item_date ||= @customer.product_item_dates.find(params[:product_item_date_id])
    end

    def set_products
      @products = @business.products
    end
end
