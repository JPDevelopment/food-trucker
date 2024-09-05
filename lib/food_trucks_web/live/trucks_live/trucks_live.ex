defmodule FoodTrucksWeb.TrucksLive do
  use FoodTrucksWeb, :live_view

  alias FoodTrucks.Trucks

  def mount(_params, _session, socket) do
    {:ok, assign(socket, trucks: Trucks.list_trucks(), item: "", loading: false)}
  end

  def render(assigns) do
    ~H"""
    <h1>Search Trucks By Menu Options</h1>
    <br />

    <form phx-change="search" phx-submit="search">
      <input
        type="text"
        name="item"
        value={@item}
        placeholder="What are you craving?"
        autofocus
        autocomplete="off"
        readonly={@loading}
        phx-debounce="1000"
      />

      <button>
        <img src="/images/search.svg" />
      </button>
    </form>

    <div :if={@loading}>
      <p>Loading...</p>
    </div>

    <.table id="trucks" rows={@trucks} row_click={&JS.navigate(~p"/trucks/#{&1}")}>
      <:col :let={truck} label="Name"><%= truck.name %></:col>
      <:col :let={truck} label="Location"><%= truck.location_description %></:col>
    </.table>
    """
  end

  def handle_event("search", %{"item" => item}, socket) do
    send(self(), {:run_search, item})

    socket =
      assign(socket,
        item: item,
        trucks: [],
        loading: true
      )

    {:noreply, socket}
  end

  def handle_info({:run_search, item}, socket) do
    socket =
      assign(socket,
        trucks: Trucks.filter_trucks_by_item(item),
        loading: false
      )

    {:noreply, socket}
  end
end
