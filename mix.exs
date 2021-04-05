defmodule Sms77.Mixfile do
  use Mix.Project

  def project do
    [
      app: :sms77,
      deps: deps(),
      docs: [
        readme: "README.md",
        main: "README"
      ],
      description: description(),
      elixir: "~> 1.7",
      package: package(),
      source_url: "https://github.com/sms77io/elixir",
      version: "0.1.0",
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    """
    A basic Elixir wrapper for the Sms77.io SMS Gateway API.
    """
  end

  defp deps do
    [
      {:elixir_uuid, "~> 1.2"},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      {:exvcr, "~> 0.12", only: :test},
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.2"},
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/sms77io/elixir"
      },
      maintainers: ["sms77 e.K."],
    ]
  end
end