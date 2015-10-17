defmodule Excelerator.Phoenix do
  defmacro __using__(options) do
    quote do
      def xls(conn, template, data, opts \\ []) do
        excel_data = view_module(conn).render(template, data)

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
