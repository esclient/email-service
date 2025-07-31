defmodule Emailservice.MixProject do
  use Mix.Project

  def project do
    [
      app: :emailservice,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      protoc_options: [gen_descriptors: true],
      deps: deps()
    ]
  end

  defp elixirc_paths(_env), do: ["grpc", "lib"]

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:grpc, "~> 0.6"},
      {:protobuf, "~> 0.10"},
      {:grpc_reflection, "~> 0.2.0"},
      {:swoosh, "~> 1.14"},
      {:dotenvy, "~> 1.0"},
      {:finch, "~> 0.18"}
    ]
  end
end
