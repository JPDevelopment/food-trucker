defmodule FoodTrucks.Repo.Migrations.CreateTrucks do
  use Ecto.Migration

  def change do
    create table(:trucks) do
      add :location_id, :integer, null: false
      add :name, :string, size: 100, null: false
      add :type, :string, size: 20, null: false
      add :cnn, :integer
      add :location_description, :string, size: 255
      add :address, :string, size: 100
      add :block_lot, :string, size: 20
      add :block, :string, size: 20
      add :lot, :string, size: 20
      add :permit, :string, size: 20
      add :status, :string, null: false
      add :food_items, :text

      timestamps(type: :utc_datetime)
    end
  end
end
