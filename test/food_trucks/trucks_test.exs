defmodule FoodTrucks.TrucksTest do
  use FoodTrucks.DataCase

  alias FoodTrucks.Trucks

  describe "trucks" do
    alias FoodTrucks.Trucks.Truck

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

    test "list_trucks/0 returns all trucks" do
      truck = truck_fixture()
      assert Trucks.list_trucks() == [truck]
    end

    test "get_truck!/1 returns the truck with given id" do
      truck = truck_fixture()
      assert Trucks.get_truck!(truck.id) == truck
    end

    test "create_truck/1 with valid data creates a truck" do
      valid_attrs = %{
        block: "some block",
        name: "some name",
        status: :APPROVED,
        type: "Truck",
        address: "some address",
        permit: "some permit",
        location_id: 42,
        cnn: 42,
        location_description: "some location_description",
        block_lot: "some block_lot",
        lot: "some lot",
        food_items: "some food_items"
      }

      assert {:ok, %Truck{} = truck} = Trucks.create_truck(valid_attrs)
      assert truck.block == "some block"
      assert truck.name == "some name"
      assert truck.status == :APPROVED
      assert truck.type == "Truck"
      assert truck.address == "some address"
      assert truck.permit == "some permit"
      assert truck.location_id == 42
      assert truck.cnn == 42
      assert truck.location_description == "some location_description"
      assert truck.block_lot == "some block_lot"
      assert truck.lot == "some lot"
      assert truck.food_items == "some food_items"
    end

    test "create_truck/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trucks.create_truck(@invalid_attrs)
    end

    test "update_truck/2 with valid data updates the truck" do
      truck = truck_fixture()

      update_attrs = %{
        block: "some updated block",
        name: "some updated name",
        status: :EXPIRED,
        type: "Push Cart",
        address: "some updated address",
        permit: "some updated permit",
        location_id: 43,
        cnn: 43,
        location_description: "some updated location_description",
        block_lot: "updated block_lot",
        lot: "some updated lot",
        food_items: "some updated food_items"
      }

      assert {:ok, %Truck{} = truck} = Trucks.update_truck(truck, update_attrs)
      assert truck.block == "some updated block"
      assert truck.name == "some updated name"
      assert truck.status == :EXPIRED
      assert truck.type == "Push Cart"
      assert truck.address == "some updated address"
      assert truck.permit == "some updated permit"
      assert truck.location_id == 43
      assert truck.cnn == 43
      assert truck.location_description == "some updated location_description"
      assert truck.block_lot == "updated block_lot"
      assert truck.lot == "some updated lot"
      assert truck.food_items == "some updated food_items"
    end

    test "update_truck/2 with invalid data returns error changeset" do
      truck = truck_fixture()
      assert {:error, %Ecto.Changeset{}} = Trucks.update_truck(truck, @invalid_attrs)
      assert truck == Trucks.get_truck!(truck.id)
    end

    test "delete_truck/1 deletes the truck" do
      truck = truck_fixture()
      assert {:ok, %Truck{}} = Trucks.delete_truck(truck)
      assert_raise Ecto.NoResultsError, fn -> Trucks.get_truck!(truck.id) end
    end

    test "change_truck/1 returns a truck changeset" do
      truck = truck_fixture()
      assert %Ecto.Changeset{} = Trucks.change_truck(truck)
    end
  end
end
