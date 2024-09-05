defmodule FoodTrucksWeb.TruckControllerTest do
  use FoodTrucksWeb.ConnCase

  import FoodTrucks.TrucksFixtures

  @invalid_attrs %{
    block: nil,
    name: nil,
    status: nil,
    type: nil,
    address: nil,
    permit: nil,
    location_id: nil,
    cnn: nil,
    location_description: nil,
    block_lot: nil,
    lot: nil,
    food_items: nil
  }

  describe "index" do
    test "lists all trucks", %{conn: conn} do
      conn = get(conn, ~p"/trucks")
      assert html_response(conn, 200) =~ "All Food Trucks"
    end
  end

  describe "new truck" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/trucks/new")
      assert html_response(conn, 200) =~ "New Truck"
    end
  end

  describe "create truck" do
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/trucks", truck: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Truck"
    end
  end

  describe "edit truck" do
    setup [:create_truck]

    test "renders form for editing chosen truck", %{conn: conn, truck: truck} do
      conn = get(conn, ~p"/trucks/#{truck}/edit")
      assert html_response(conn, 200) =~ "Edit Truck"
    end
  end

  describe "update truck" do
    setup [:create_truck]

    test "renders errors when data is invalid", %{conn: conn, truck: truck} do
      conn = put(conn, ~p"/trucks/#{truck}", truck: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Truck"
    end
  end

  describe "delete truck" do
    setup [:create_truck]

    test "deletes chosen truck", %{conn: conn, truck: truck} do
      conn = delete(conn, ~p"/trucks/#{truck}")
      assert redirected_to(conn) == ~p"/trucks"

      assert_error_sent 404, fn ->
        get(conn, ~p"/trucks/#{truck}")
      end
    end
  end

  defp create_truck(_) do
    truck = truck_fixture()
    %{truck: truck}
  end
end
