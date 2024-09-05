defmodule FoodTrucks.Trucks.Truck do
  use Ecto.Schema
  import Ecto.Changeset

  @fields ~w(location_id name type cnn location_description address block_lot block lot permit status food_items)a
  @required_fields ~w(location_id name type status)a
  @truck_types ["Truck", "Push Cart"]

  schema "trucks" do
    field :block, :string
    field :name, :string
    field :status, Ecto.Enum, values: [:APPROVED, :EXPIRED, :REQUESTED, :ISSUED, :SUSPEND]
    field :type, :string, default: "Truck"
    field :address, :string
    field :permit, :string
    field :location_id, :integer
    field :cnn, :integer
    field :location_description, :string
    field :block_lot, :string
    field :lot, :string
    field :food_items, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(truck, attrs) do
    truck
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> validate_inclusion(:type, @truck_types)
    |> validate_length(:name, max: 100)
    |> validate_length(:location_description, max: 255)
    |> validate_length(:address, max: 100)
    |> validate_length(:block_lot, max: 20)
    |> validate_length(:block, max: 20)
    |> validate_length(:lot, max: 20)
    |> validate_length(:permit, max: 20)
  end
end
