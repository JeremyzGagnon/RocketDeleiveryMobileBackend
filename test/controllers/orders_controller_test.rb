class OrdersControllerTest < ActionDispatch::IntegrationTest

  def setup
    user = User.create!(name: "User 1", email: "test@test.com", password: "password")
    address = Address.create!(street_address: "Street 1", city: "City 1", postal_code: "11111")
    restaurant = Restaurant.create!(user: user, address: address, name: "Restaurant 1", phone: "123456", price_range: 2)
    customer = Customer.create!(user: user, address: address, phone: "123456")
    product = Product.create!(name: "Product 1", cost: 10, restaurant: restaurant)
    order_status = OrderStatus.create(name: "pending")
    OrderStatus.create(name: "in progress")
    OrderStatus.create(name: "delivered")
    @order = Order.create!(restaurant: restaurant, customer: customer, order_status: order_status, restaurant_rating: 4)
  end

#   test "200 ok" do
#     get "/api/orders", params: {type: ["customer", "restaurant", "courier"], id: integer}
#     assert_response 200
#     # assert_equal {
#     #   "id": :id,

#     # }
#   test "return 422 error for invalid user type" do
#     get "/api/orders", params: {type: ["customer", "restaurant", "courier"], id: integer}
#     assert_response 422
#     assert_equal ({"error: invalid user type"}.to_json, response.body)

#   end

#   test "return 200 response for id not found" do
#     get "/api/orders", params: {type: ["customer", "restaurant", "courier"], id: integer}
#     assert_response 200
#     assert_equal ([], response.body)
#   end

#   test "return 400 error for empty user type and id" do
#     get "/api/orders", params: {type: nil, id: nil}
#     assert_response 400
#     assert_equal ({"error: Both 'user type' and 'id' parameters are required"}.to_json, response.body)
    
#   end



#   test "return 200 creates a new order" do
#     post "/api/orders", params: { restaurant_id: nil, customer_id: nil, products: nil }
#     assert_response 422
#     assert_equal ({
#         "restaurant_id": params[:restaurant_id],
#         "customer_id": params[:customer_id],
#         "products": [{}]
#     }, response.body)
#   end

#   test "return 422 error for no restaurant, customer and product id" do
#     post "/api/orders", params: {restaurant_id: nil, customer_id: nil, products: nil}
#     assert_response 422
#     assert_equal "error: Restaurant ID, customer ID, and products are required", response.body

#   end

#   test "return 422 error for no restaurant, customer and product id" do
#     post "/api/orders", params: {restaurant_id: "not_an_integer", customer_id: "not_an_integer"}
#     assert_response 422
#     assert_equal "error: Invalid restaurant or customer ID", response.body
#   end

#   test "return 422 error for no restaurant, customer and product id" do
#     post "/api/orders", params: {product: "not_an_integer"}
#     assert_response 422
#     assert_equal "error: Invalid product ID", response.body
#   end







  test "update order status to 'pending'" do
    post "/api/order/#{@order.id}/status", params: { status: "pending" }
    assert_response :success
    assert_equal "pending", @order.reload.order_status.name
  end

  test "update order status to 'in progress'" do
    post "/api/order/#{@order.id}/status", params: { status: "in progress" }
    assert_response :success
    assert_equal "in progress", @order.reload.order_status.name
  end

  test "update order status to 'delivered'" do
    post "/api/order/#{@order.id}/status", params: { status: "delivered" }
    assert_response :success
    assert_equal "delivered", @order.reload.order_status.name
  end

  test "return 422 error for invalid status" do
    post "/api/order/#{@order.id}/status", params: { status: "invalid" }
    assert_response 422
  end

  test "return 422 error for invalid order" do
    post "/api/order/0/status", params: { status: "pending" }
    assert_response 422
  end

end