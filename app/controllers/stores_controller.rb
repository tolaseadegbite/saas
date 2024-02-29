class StoresController < ApplicationController
    before_action :authenticate_user!
    before_action :find_business
    before_action :find_store, only: [:show, :edit, :update, :destroy]
    before_action :find_correct_user, only: [:show, :edit, :update, :destroy]
    before_action :find_products

    def index
        @stores = @business.stores.includes(:business, :user)
    end

    def show
        
    end

    def new
        @store = Store.new
        @store.store_products.build
    end

    def create
        @store = @business.stores.build(store_params)
        @store.user = current_user
        if @store.save
            respond_to do |format|
                format.html { redirect_to business_store_path(@business, @store), notice: 'store successfully created' }
            end
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @store.store_products.build
    end

    def update
        if @store.update(store_params)
            respond_to do |format|
                format.html { redirect_to business_store_url(@business, @store), notice: 'store successfully updated' }
            end
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @store.destroy
        respond_to do |format|
            format.html { redirect_to business_stores_url(@business), notice: 'store deleted!' }
        end
    end

    private

    def store_params
        params.require(:store).permit!
    end

    def find_store
      @store ||= Store.find(params[:id])
    end

    def find_business
        @business ||= Business.find(params[:business_id])
    end

    def find_products
        @business = Business.find(params[:business_id])
        @products ||= @business.products.pluck(:name, :id)
    end

    def find_correct_user
        @store ||= Store.find(params[:id])
        redirect_to(businesses_url, status: :see_other, notice: "Access denied, not your store.") unless @store.user == current_user
    end
end
