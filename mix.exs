defmodule Tofu.MixProject do
  use Mix.Project

  def project do
    [
      app: :tofu,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Tofu.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:exirc, "~> 2.0.0"},
      {:plug_cowboy, "~> 2.0"},
      {:cubdb, "~> 1.0.0"},
      {:jason, "~> 1.2"}
    ]
  end
end
