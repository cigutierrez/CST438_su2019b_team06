    
class Customer < ApplicationRecord
    
    validates_presence_of :email, :lastName, :firstName
    validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: "doesn't look like a proper email address"
    validates_uniqueness_of :email, case_sensitive: false, message: "email has already been registered"
        
    def award 
        # calculate award amount from last 3 orders. 
        # if customer has not done 3 purchases (since last award) award is 0.00
        award = 0
        if self.lastOrder > 0 && self.lastOrder2 > 0 && self.lastOrder3 > 0
            # award amount is 10% of average of last 3 orders
            award = (self.lastOrder + self.lastOrder2 + self.lastOrder3) / 3.0 * 0.10
        end
        award.round(2)
    end
    
    def processOrder(params)
        if params[:award].present? && params[:award] > 0
            # award has been redeemed. reset last 3 orders
            self.lastOrder = 0
            self.lastOrder2 = 0
            self.lastOrder3 = 0
        else
            # otherwise, record the amount for this order for future award
            self.lastOrder3 = self.lastOrder2
            self.lastOrder2 = self.lastOrder
            self.lastOrder = params[:total]
        end
    end
    
    def Customer.getCustomerByEmail(email)
        response = get "/customers?email=#{email}", headers: {  "ACCEPT" => "application/json"}
            status = response.code
            customer = JSON.parse response.body, symbolize_names: true
        # return status code and ruby hash with customer data
        return status, customer
    end
    
    def Customer.putOrder(order)
        # do put request to /customers/orders
        response = put "/customers/order", body:  order.to_json, headers: { "CONTENT_TYPE" => "application/json" }
        response.code
    end
end