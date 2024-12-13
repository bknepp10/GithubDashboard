defmodule GithubDash.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GithubDashWeb.Telemetry,
      GithubDash.Repo,
      {DNSCluster, query: Application.get_env(:github_dash, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: GithubDash.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: GithubDash.Finch},
      # Start a worker by calling: GithubDash.Worker.start_link(arg)
      # {GithubDash.Worker, arg},
      # Start to serve requests, typically the last entry
      GithubDashWeb.Endpoint,
      GithubDash.GithubBroker
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GithubDash.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GithubDashWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
