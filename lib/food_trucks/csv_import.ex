defmodule FoodTrucks.CsvImport do
  @moduledoc """
  Functions to parse the Food Truck CSV file.
  """

  @doc """
  Decode the Food Truck data CSV and create a list of maps for DB insert.
  """
  def prepare_csv_for_insert(path_to_csv) do
    File.stream!(path_to_csv)
    |> CSV.decode!(headers: true)
    |> Enum.map(fn truck ->
      %{
        address: truck["Address"],
        block: truck["block"],
        block_lot: truck["blocklot"],
        cnn: truck["cnn"],
        food_items: truck["FoodItems"],
        location_description: truck["LocationDescription"],
        location_id: truck["locationid"],
        lot: truck["lot"],
        name: truck["Applicant"],
        permit: truck["permit"],
        status: truck["Status"],
        type: truck["FacilityType"]
      }
    end)
  end
end
