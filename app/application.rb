class Application

    @@items = [Item.new("Shoes", 50), Item.new("Bags", 100), Item.new("Shades", 70)]

    def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)
  
      if req.path.match(/items/)
        item = req.path.split("/items/").last
        if found = @@items.find{|i| i.name == item}
          resp.write found.price
        else 
          resp.status = 400
          resp.write "Item not found"
        end
      else
        resp.status = 404
        resp.write "Route not found"
      end
      resp.finish
    end

end