defmodule Excelerator.WorkbookTest do
  use ExUnit.Case
  doctest Excelerator.Workbook

  import Excelerator.Workbook

  test "top-level workbook structure" do
    xml = workbook do: []
    assert xml == """
    <?xml version="1.0" encoding="UTF-8" ?>
    <Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:x="urn:schemas-microsoft-com:office:excel">
    	<Styles>
    		<Style ss:ID="Default" ss:Name="Normal">
    			<Alignment ss:Vertical="Bottom"/>
    			<Borders/>
    			<Font ss:FontName="Verdana"/>
    			<Interior/>
    			<NumberFormat/>
    			<Protection/>
    		</Style>
    	</Styles>

    </Workbook>
    """ |> String.rstrip
  end

  test "worksheet with default name" do
    sheet = worksheet do: :content
    assert sheet == {:Worksheet, %{"ss:Name" => "Sheet1"}, [Table: [:content]]}
  end

  test "worksheet with custom name" do
    sheet = worksheet "Custom", do: :content
    assert sheet == {:Worksheet, %{"ss:Name" => "Custom"}, [Table: [:content]]}
  end

  test "row" do
    r = row do
    end
    assert r == {:Row, []}
  end

  defmodule User do
    defstruct name: "John", age: 27
  end

  test "row with cells" do
    user = %User{}

    r = row do
      cell "Hello"
      cell 123
      cell user.name
    end

    assert r == {:Row, [
      {:Cell, [{:Data, %{"ss:Type" => "String"}, "Hello"}]},
      {:Cell, [{:Data, %{"ss:Type" => "Number"}, 123}]},
      {:Cell, [{:Data, %{"ss:Type" => "String"}, "John"}]},
    ]}
  end
end
