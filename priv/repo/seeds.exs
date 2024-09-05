path_to_csv = "priv/repo/mobile_food_facility_permit.csv"
trucks = FoodTrucks.CsvImport.prepare_csv_for_insert(path_to_csv)

Enum.each(trucks, fn truck ->
  truck = FoodTrucks.Trucks.change_truck(%FoodTrucks.Trucks.Truck{}, truck)

  FoodTrucks.Repo.insert!(truck)
end)
