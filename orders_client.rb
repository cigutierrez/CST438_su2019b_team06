require 'httparty'

class OrderClient
    include HTTParty
    
    base_uri "http://localhost:8080"
        format :json
        
    def self.create(order)
        post '/orders', body: order.to_json, headers:  { 'Content-Type' => 'application/json', 'ACCEPT' => 'application/json' }
    end
    
    def self.getId(id)
        get "/orders/#{id}", headers:  { 'ACCEPT' => 'application/json' }
    end
end

while true
    puts "What do you want to do: (1) Purchase, (2) Order lookup, or quit?"
    cmd = gets.chomp!
    puts
    case cmd
        when 'quit'
            break
        when '1'  # create order
            puts 'enter item id'
            itemId = gets.chomp!
            puts 'enter email'
            email = gets.chomp!
            response = OrderClient.create itemId: itemId, email: email
            puts "status code #{response.code}"
            puts response.body unless response.code==500
            puts
        when '2'  # order lookup
            puts 'enter id of order to lookup'
            id = gets.chomp!
            response = OrderClient.getId(id)
            puts "status code #{response.code}"
            puts response.body unless response.code==500
            puts
        else
            puts "I don't understand.  Enter the number of the action to perform (ex.  3  ) or quit"
            puts
    end
end 
