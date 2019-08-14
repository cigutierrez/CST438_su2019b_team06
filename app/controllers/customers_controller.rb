class CustomersController < ApplicationController
    def create
        @customer = Customer.new
        @customer.email = params[:email]
        @customer.lastName = params[:lastName]
        @customer.firstName = params[:firstName]
        @customer.lastOrder = 0
        @customer.lastOrder2 = 0
        @customer.lastOrder3 = 0
        customerSaved = @customer.save
        if customerSaved
            render "customer.json.jbuilder", status: 201
        else
            render(json: {messages: @customer.errors.messages}, status: 400)
        end
    end
    
    def index 
        if params[:id].present?
            @customer = Customer.find_by(id: params[:id])
        elsif params[:email].present?
            @customer = Customer.find_by(email: params[:email])
        end
        
        if @customer.nil?
            message = {:id => ['Record not found or id= or email= missing.'] }
            render(json: {messages: [ message ] }, status: 404 )
        else
            render "customer.json.jbuilder"
        end
    end
    
    def processOrder
        @customer = Customer.find_by( :id => params[:customerId] )
        if @customer.nil?
            head  404
        else 
            @customer.processOrder(params)
            @customer.save
            head  204
        end
    end
    
end