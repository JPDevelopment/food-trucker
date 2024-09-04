defmodule FoodTrucksWeb.TruckControllerTest do
  use FoodTrucksWeb.ConnCase

  import FoodTrucks.TrucksFixtures

  @create_attrs %{block: "some block", name: "some name", status: :APPROVED, type: "some type", address: "some address", permit: "some permit", location_id: 42, cnn: 42, location_description: "some location_description", block_lot: "some block_lot", lot: "some lot", food_items: "some food_items"}
  @update_attrs %{block: "some updated block", name: "some updated name", status: :EXPIRED, type: "some updated type", address: "some updated address", permit: "some updated permit", location_id: 43, cnn: 43, location_description: "some updated location_description", block_lot: "some updated block_lot", lot: "some updated lot", food_items: "some updated food_items"}
  @invalid_attrs %{block: nil, name: nil, status: nil, type: nil, address: nil, permit: nil, location_id: nil, cnn: nil, location_description: nil, block_lot: nil, lot: nil, food_items: nil}

  describe "index" do
    test "lists all trucks", %{conn: conn} do
      conn = get(conn, ~p"/trucks")
      assert html_response(conn, 200) =~ "Listing Trucks"
    end
  end

  describe "new truck" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/trucks/new")
      assert html_response(conn, 200) =~ "New Truck"
    end
  end

  describe "create truck" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/trucks", truck: @create_attrs)

      assert %{id: id} = redirected_params(conn)

      conn = get(conn, ~p"/trucks/#{id}")
      assert html_response(conn, 200) =~ "Truck #{id}"
    end

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

    test "redirects when data is valid", %{conn: conn, truck: truck} do
      conn = put(conn, ~p"/trucks/#{truck}", truck: @update_attrs)

      conn = get(conn, ~p"/trucks/#{truck}")
      assert html_response(conn, 200) =~ "updated block"
    end

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
