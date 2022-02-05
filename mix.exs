defmodule Snowtracex.MixProject do
  use Mix.Project

  @source_url "https://github.com/mcaneris/snowtracex"
  @version "0.1.1"
  @maintainers ["Mete Can Eris"]

  def project do
    [
      app: :snowtracex,
      description: "Simple wrapper library for Snowtrace Developer APIs",
      version: @version,
      elixir: "~> 1.12",
      package: package(),
      docs: docs(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: @source_url
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      maintainers: @maintainers,
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla, "~> 1.4"},
      {:hackney, "~> 1.17"},
      {:jason, ">= 1.0.0"},

      # Code Analysis
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},

      # Documentation
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      extras: ["README.md", "LICENSE"],
      groups_for_modules: []
    ]
  end
end
