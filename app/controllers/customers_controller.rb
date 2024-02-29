class CustomersController < ApplicationController
    before_action :authenticate_user!
    before_action :find_business
    before_action :find_customer, only: [:show, :edit, :update, :destroy]
    before_action :find_correct_user, only: [:show, :edit, :update, :destroy]

    def index
        @customers = @business.customers.includes(:business, :user)
    end

    def show
        
    end

    def new
        @customer = Customer.new
    end

    def create
        @customer = @business.customers.build(customer_params)
        @customer.user = current_user
        if @customer.save
            respond_to do |format|
                format.html { redirect_to business_customers_url(@business), notice: 'Customer successfully created' }
            end
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        
    end

    def update
        if @customer .update(customer_params)
            respond_to do |format|
                format.html { redirect_to business_customers_url(@business), notice: 'Customer successfully updated' }
            end
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @customer.destroy
        respond_to do |format|
            format.html { redirect_to business_customers_url(@business), notice: 'Customer deleted!' }
        end
    end

    private

    def customer_params
        params.require(:customer).permit(:name, :email, :phone_number)
    end

    def find_customer
      @customer ||= Customer.find(params[:id])
    end

    def find_business
        @business ||= Business.find(params[:business_id])
    end

    def find_correct_user
        @customer ||= Customer.find(params[:id])
        redirect_to(businesses_url, status: :see_other, notice: "Access denied, not your customer.") unless @customer.user == current_user
    end
end
