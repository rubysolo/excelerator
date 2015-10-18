defmodule Excelerator.Phoenix do
  @moduledoc """
  Provides the `xls` function for rendering Excel spreadsheets as file downloads
  from Phoenix controllers.

  ## Using

  When used, `Excelerator.Phoenix` generates the `xls` function in your
  controller so you can send file downloads like:

      xls conn, "invoice.xls", items: line_items

  The attachment filename defaults to the same name as the controller, but can
  be overridden with the `:filename` option.

      xls conn, "template.xls", data, filename: "SrsBizness.xls"

  """

  defmacro __using__(_options) do
    quote do
      def xls(conn, template, assigns, opts \\ []) do
        excel_data = view_module(conn).render(template, assigns)

        default_filename = Phoenix.Naming.resource_name(__MODULE__, "Controller") <> ".xls"
        filename = Keyword.get(opts, :filename, default_filename)

        conn
        |> put_resp_content_type("application/vnd.ms-excel")
        |> put_resp_header("content-disposition", "attachment; filename=#{ filename }")
        |> send_resp(conn.status || 200, excel_data)
      end
    end
  end
end
