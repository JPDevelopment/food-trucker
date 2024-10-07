defmodule FoodTrucksWeb.TrucksLive do
  use FoodTrucksWeb, :live_view

  alias FoodTrucks.Trucks

  def mount(_params, _session, socket) do
    {:ok, assign(socket, trucks: [], item: "", loading: false)}
  end

  def render(assigns) do
    ~H"""
    <h1 class="title">Search Trucks By Menu Options</h1>
    <br />

    <div class="container">
      <div class="columns">
        <div class="column is-one-half">
          <form phx-change="search" phx-submit="search">
            <input
              class="input is-medium"
              size="1"
              type="text"
              name="item"
              value={@item}
              placeholder="What are you craving?"
              autofocus
              autocomplete="off"
              readonly={@loading}
              phx-debounce="1000"
            />
          </form>
        </div>
      </div>
    </div>

    <div :if={@loading}>
      <p>Loading...</p>
    </div>

    <div class="content">
      <%= if @item == "" do %>
        <h1 class="title is-5">Awaiting Search...</h1>
      <% else %>
        <%= if @trucks == [] do %>
          <h1 class="title is-5">Sorry, that's not on any menus...</h1>
        <% else %>
          <%= for truck <- @trucks do %>
            <h1 class="title is-3"><%= truck.name %></h1>
            <p class="subtitle is-4"><%= truck.menu %></p>
            <table class="table">
              <thead>
                <tr>
                  <th>Locations</th>
                </tr>
              </thead>
              <tbody>
                <%= for location <- truck.locations do %>
                  <tr>
                    <td><%= location %></td>
                  </tr>
                <% end %>
              </tbody>
            </table>
          <% end %>
        <% end %>
      <% end %>
    </div>
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
        trucks: group_trucks_by_name(item),
        loading: false
      )

    {:noreply, socket}
  end

  # Organize trucks by name with list of locations and searched food item
  defp group_trucks_by_name(searched_item) do
    Trucks.filter_trucks_by_item(searched_item)
    |> Enum.group_by(& &1.name)
    |> Enum.map(fn {truck_name, trucks} ->
      menu =
        trucks
        |> List.first()
        |> Map.get(:food_items)
        |> format_food_items(searched_item)

      locations =
        trucks
        |> Enum.map(& &1.location_description)
        |> Enum.reject(&is_nil(&1))

      %{name: truck_name, locations: locations, menu: menu}
    end)
  end

  # Filter out irrelevant food items and format for use in rendering the results
  # TODO: Better normalization of food items
  defp format_food_items(food_items, searched_item) do
    food_items
    |> String.split(":")
    |> Enum.map(&String.trim/1)
    |> Enum.filter(fn item ->
      String.contains?(String.downcase(item), String.downcase(searched_item))
    end)
    |> Enum.join(", ")
  end
end
