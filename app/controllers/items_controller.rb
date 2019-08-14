class ItemsController < ApplicationController
    def create
        @item = Item.new
        @item.description = params[:description]
        @item.price = params[:price]
        @item.stockQty = params[:stockQty]
        itemSaved = @item.save
        if itemSaved
            render json: @item.to_json, status:201
        else
            head 400
        end
    end
    
    def get
        @id = params[:id]
        @item = nil
        if !@id.nil?
            @item = Item.find_by(id: @id)
        end
        
        if !@item.nil?
            render json: @item.to_json, status:200
        else
            head 404
        end
    end
    
    def updateItem
        @id = params[:id]
        @price = params[:price]
        @description = params[:description]
        @stockQty = params[:stockQty]
        @item = Item.find_by(id: @id)
        @item.description = @description
        @item.price = @price
        @item.stockQty = @stockQty
        @item.save
        
        if !@item.nil?
            render json: @item.to_json, status:204
        else
            head 404
        end
    end
end
