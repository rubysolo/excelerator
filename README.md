# Excelerator

Excel spreadsheet generation for Elixir

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add excelerator to your list of dependencies in `mix.exs`:

        def deps do
          [{:excelerator, "~> 0.0.1"}]
        end

## Usage

  1. Import `Excelerator.Workbook` into your module, then generate the XML content:

        workbook do
          worksheet "My Sheet" do
            row do
              cell "Name"
              cell "Status"
            end

            row do
              cell "Elixir"
              cell 1
            end
          end
        end

        # => <?xml version="1.0" encoding="UTF-8" ?><Workbook ...

## Usage with Phoenix

  1. Use `Excelerator.Phoenix` in your controller:

        defmodule MyApp.MyController do
          use MyApp.Web, :controller
          use Excelerator.Phoenix

  1. Import `Excelerator.Workbook` into your view module:

        defmodule MyApp.MyView do
          use MyApp.Web, :view
          import Excelerator.Workbook

     (Alternatively, add the use / import statements to the appropriate sections
     of `web/web.ex`, which will make excelerator available in all controllers/
     views.)

  1. Call `xls` in your controller action to send content as a file download:

        def show(conn, %{"format" => "xls"} = params) do
          xls conn, "show.xls", favorite: "Elixir"
        end

  1. Create `web/templates/RESOURCE/NAME.xls.exs`

        workbook do
          worksheet "My Sheet" do
            row do
              cell "Name"
              cell "Status"
            end

            row do
              cell assigns.favorite
              cell 1
            end
          end
        end
