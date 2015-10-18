defmodule Excelerator.Mixfile do
  use Mix.Project

  def project do
    [
      app: :excelerator,
      version: "0.0.1",
      elixir: "~> 1.0",
      name: "excelerator",
      source_url: "https://github.com/rubysolo/excelerator",
      description: description,
      package: package,
      deps: deps,
      docs: [extras: ["README.md"]]
    ]
  end

  def application do
    [applications: [:logger]]
  end

  def description do
    """
    Generate Excel workbooks in Elixir
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
      {:xml_builder, github: "joshnuss/xml_builder"},
      {:earmark, "~> 0.1", optional: true},
    ]
  end
end
