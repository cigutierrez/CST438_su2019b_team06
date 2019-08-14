require 'httparty'

class ItemClient
    include HTTParty
    
    base_uri "http://localhost:8080"
    format :json
    
    def self.create(it)
        post '/items', body: it.to_json, headers: { 'Content-Type' => 'application/json', 'ACCEPT' => 'application/json' }
    end
    
    def self.getId(id)
        get "/items?id=#{id}"
    end
    
    def self.update(it)
        put '/items', body: it.to_json, headers: { 'Content-Type' => 'application/json', 'ACCEPT' => 'application/json' }
    end
end

while true
    puts "What do you want to do: create, update, get, or quit"
    cmd = gets.chomp!
    case cmd
        when 'quit'
            break
        when 'create'
            puts 'enter item description'
            descData = gets.chomp!
            puts 'enter item price'
            priceData = gets.chomp!
            puts 'enter item stockQty'
            stockData = gets.chomp!
            response = ItemClient.create description: descData, price: priceData, stockQty: stockData
            puts "status code #{response.code}"
            puts response.body
        when 'get'
            puts 'enter id of item to lookup'
            idData = gets.chomp!
            response = ItemClient.getId(idData)
            puts "status code #{response.code}"
            puts response.body
        when 'update'
            puts 'enter id of item to update'
            idData = gets.chomp!
            puts 'enter description'
            descData = gets.chomp!
            puts 'enter price'
            priceData = gets.chomp!
            puts 'enter item stockQty'
            stockData = gets.chomp!
            response = ItemClient.update id: idData, description: descData, price: priceData, stockQty: stockData
            puts "status code #{response.code}"
            puts response.body
    end
end