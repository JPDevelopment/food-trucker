defmodule FoodTrucks.TrucksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodTrucks.Trucks` context.
  """

  @doc """
  Generate a truck.
  """
  def truck_fixture(attrs \\ %{}) do
    {:ok, truck} =
      attrs
      |> Enum.into(%{
        address: "some address",
        block: "some block",
        block_lot: "some block_lot",
        cnn: 42,
        food_items: "some food_items",
        location_description: "some location_description",
        location_id: 42,
        lot: "some lot",
        name: "some name",
        permit: "some permit",
        status: :APPROVED,
        type: "Truck"
      })
      |> FoodTrucks.Trucks.create_truck()

    truck
  end
end
