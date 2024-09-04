defmodule FoodTrucksWeb.TruckHTML do
  use FoodTrucksWeb, :html

  embed_templates "truck_html/*"

  @doc """
  Renders a truck form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def truck_form(assigns)
end
