class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    @@items = [Item.new("Figs", 3.42), Item.new("Pears", 0.99)]

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last

      item_obj = @@items.find do |item|
        item.name == item_name
      end

      if item_obj
        resp.write "#{item_obj.name} are priced at #{item_obj.price}"
      else
        resp.write "Item not found."
        resp.status = 400
      end
    else
      resp.write "Route not found."
      resp.status = 404
    end

    resp.finish
  end

end
