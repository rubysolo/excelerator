defmodule Excelerator.Mixfile do
  use Mix.Project

  def project do
    [
      app: :excelerator,
      version: "0.0.1",
      elixir: "~> 1.0",
      description: description,
      package: package,
      deps: deps
    ]
  end

  def application do
    [applications: [:logger]]
  end

  def description do
    """
    Generate Excel workbooks
    """
  end

  defp package do
    [
      files:      ~w[ lib README.md mix.exs LICENSE ],
      contributors: ["Solomon White"],
      licences:     ["The MIT License (MIT)"],
      links: %{
        "GitHub" => "https://github.com/rubysolo/excelerator",
        "Docs"   => "http://hexdocs.pm/excelerator",
      }
    ]
  end

  defp deps do
    [
      {:xml_builder, github: "joshnuss/xml_builder"}
    ]
  end
end
