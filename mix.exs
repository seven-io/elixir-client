defmodule Seven.Mixfile do
  use Mix.Project

  def project do
    [
      app: :seven,
      deps: deps(),
      docs: [
        readme: "README.md",
        main: "README"
      ],
      description: description(),
      elixir: "~> 1.7",
      package: package(),
      preferred_cli_env: [
        vcr: :test, "vcr.delete": :test, "vcr.check": :test, "vcr.show": :test
      ],
      source_url: "https://github.com/seven-io/elixir-client",
      version: "0.1.0",
    ]
  end

  def application do
    [
      extra_applications: [:logger, :crypto]
    ]
  end

  defp description do
    """
    The official Elixir wrapper for the seven.io API.
    """
  end

  defp deps do
    [
      {:elixir_uuid, "~> 1.2"},
      {:ex_doc, "~> 0.30", only: :dev, runtime: false},
      {:exvcr, "~> 0.14", only: :test},
      {:httpoison, "~> 2.1"},
      {:jason, "~> 1.4"},
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/seven-io/elixir-client"
      },
      maintainers: ["seven communications GmbH & Co. KG"],
    ]
  end
end
