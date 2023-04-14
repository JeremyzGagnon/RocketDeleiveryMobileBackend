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

# # My get tests

  test "order route exists and is GET route" do
    assert_routing({ path: '/api/orders', method: :get }, { controller: 'api/orders', action: 'index' })
  end

  test "get orders with valid type and id parameters" do
    user = User.create!(name: "User 1", email: "test1@test.com", password: "password")
    address = Address.create!(street_address: "Street 1", city: "City 1", postal_code: "11111")
    customer = Customer.create!(user: user, address: address, phone: "123456")
    get "/api/orders", params: { type: 'customer', id: customer.id }
    assert_response :success
    assert_not_nil @controller.instance_variable_get(:@order)
  end

  test "get orders with invalid type parameter" do
    user = User.create!(name: "User 1", email: "test1@test.com", password: "password")
    address = Address.create!(street_address: "Street 1", city: "City 1", postal_code: "11111")
    customer = Customer.create!(user: user, address: address, phone: "123456")
    get "/api/orders", params: { type: 'invalid', id: customer.id }
    assert_response 422
    assert_equal({ error: "Invalid user type parameter" }.to_json, response.body)

  end

  test "get orders with nil type and id parameter" do
    user = User.create!(name: "User 1", email: "test1@test.com", password: "password")
    address = Address.create!(street_address: "Street 1", city: "City 1", postal_code: "11111")
    customer = Customer.create!(user: user, address: address, phone: "123456")
    get "/api/orders", params: { type: nil, id: nil}
    assert_response 400
    assert_equal({ error: "Both 'user type' and 'id' parameters are required" }.to_json, response.body)

  end



# # My post test

test "create an order" do
  user2 = User.create!(name: "User 2", email: "test@test3.com", password: "password")
  address2 = Address.create!(street_address: "Street 2", city: "City 2", postal_code: "2222")
  restaurant2 = Restaurant.create!(user: user2, address: address2, name: "Restaurant 2", phone: "234567", price_range: 3)
  customer2 = Customer.create!(user: user2, address: address2, phone: "123456")
  product1 = Product.create!(name: "Product 1", cost: 10, restaurant: restaurant2)
  product2 = Product.create!(name: "Product 2", cost: 100, restaurant: restaurant2)

  post "/api/orders", params: {
    restaurant_id: restaurant2.id,
    customer_id: customer2.id,
    products: [
      { id: product1.id, quantity: 1, cost: 10 },
      { id: product2.id, quantity: 2, cost: 10}
    ]
  }
  assert_response :success
  assert_not_nil @controller.instance_variable_get(:@order)
end

test "create an order with missing data" do
  post "/api/orders"
  assert_response 400
  assert_equal({ error: "Restaurant ID, customer ID, and products aer required" }.to_json, response.body)
end



# # Premade test
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