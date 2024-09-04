defmodule FoodTrucksWeb.TruckController do
  use FoodTrucksWeb, :controller

  alias FoodTrucks.Trucks
  alias FoodTrucks.Trucks.Truck

  def index(conn, _params) do
    trucks = Trucks.list_trucks()
    render(conn, :index, trucks: trucks)
  end

  def new(conn, _params) do
    changeset = Trucks.change_truck(%Truck{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"truck" => truck_params}) do
    case Trucks.create_truck(truck_params) do
      {:ok, truck} ->
        conn
        |> put_flash(:info, "Truck created successfully.")
        |> redirect(to: ~p"/trucks/#{truck}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    truck = Trucks.get_truck!(id)
    render(conn, :show, truck: truck)
  end

  def edit(conn, %{"id" => id}) do
    truck = Trucks.get_truck!(id)
    changeset = Trucks.change_truck(truck)
    render(conn, :edit, truck: truck, changeset: changeset)
  end

  def update(conn, %{"id" => id, "truck" => truck_params}) do
    truck = Trucks.get_truck!(id)

    case Trucks.update_truck(truck, truck_params) do
      {:ok, truck} ->
        conn
        |> put_flash(:info, "Truck updated successfully.")
        |> redirect(to: ~p"/trucks/#{truck}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, truck: truck, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    truck = Trucks.get_truck!(id)
    {:ok, _truck} = Trucks.delete_truck(truck)

    conn
    |> put_flash(:info, "Truck deleted successfully.")
    |> redirect(to: ~p"/trucks")
  end
end
