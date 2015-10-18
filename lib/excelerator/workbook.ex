defmodule Excelerator.Workbook do
  @moduledoc """
  Provides functions to generate Excel spreadsheets.

  ## Importing

  You may want to import this module where you are generating spreadsheets.
  """

  require Logger
  import XmlBuilder

  defmacro workbook(do: content) do
    quote do
      doc(:Workbook, %{
        "xmlns"      => "urn:schemas-microsoft-com:office:spreadsheet",
        "xmlns:o"    => "urn:schemas-microsoft-com:office:office",
        "xmlns:x"    => "urn:schemas-microsoft-com:office:excel",
        "xmlns:html" => "http://www.w3.org/TR/REC-html40",
        "xmlns:ss"   => "urn:schemas-microsoft-com:office:spreadsheet"
      }, [
        unquote(styles),
        unquote(content)
      ])
    end
  end

  defmacro worksheet(name \\ "Sheet1", do: content) do
    quote do
      {:Worksheet, %{"ss:Name" => unquote(name)}, [
        {:Table, [unquote(content)]}
      ]}
    end
  end

  defmacro row(do: {_, _, statements}) do
    quote do
      {:Row, unquote(statements)}
    end
  end

  defmacro row(do: content) do
    quote do
      {:Row, unquote(content || [])}
    end
  end

  def cell(content) when is_bitstring(content), do: cell(content, "String")
  def cell(content) when is_number(content),    do: cell(content, "Number")
  def cell(content) do
    Logger.warn "Unknown content type for cell #{ inspect content }"
    cell(content, "String")
  end

  def cell(content, datatype) do
    {:Cell, [{:Data, %{"ss:Type" => datatype}, content}]}
  end

  defp styles do
    quote do
      {:Styles, [
        {:Style, %{"ss:ID" => "Default", "ss:Name" => "Normal"}, [
          {:Alignment, %{"ss:Vertical" => "Bottom"}},
          {:Borders},
          {:Font, %{"ss:FontName" => "Verdana"}},
          {:Interior},
          {:NumberFormat},
          {:Protection},
        ]}
      ]}
    end
  end
end
