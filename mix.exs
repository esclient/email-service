defmodule EmailService.MixProject do
  use Mix.Project

  def project do
    [
      app: :emailservice,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: true,
      elixirc_paths: ["lib", "grpc"],
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :swoosh, :crypto, :finch, :gen_smtp],
      mod: {EmailService, []}
    ]
  end

  defp deps do
    [
      {:grpc, "~> 0.6"},
      {:protobuf, "~> 0.10"},
      {:grpc_reflection, "~> 0.2.0"},
      {:swoosh, "~> 1.14"},
      {:gen_smtp, "~> 1.1"},
      {:dotenvy, "~> 1.0"},
      {:finch, "~> 0.18"}
    ]
  end
end
