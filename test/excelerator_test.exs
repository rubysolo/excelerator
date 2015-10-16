defmodule ExceleratorTest do
  use ExUnit.Case
  doctest Excelerator

  import Excelerator.Workbook

  test "generating a workbook" do
    cities = %{
      "Denver" => 22,
      "London" => 13,
      "Singapore" => 32
    }

    date = "2015-10-16"

    xml = workbook do
      worksheet do
        row do
          cell "City"
          cell "Temperature"
          cell "Date"
        end

        Enum.map cities, fn {city, temperature} ->
          row do
            cell city
            cell temperature
            cell date, "Date"
          end
        end
      end
    end

    assert xml == String.rstrip(File.read!("test/fixtures/test.xls"))
  end
end
