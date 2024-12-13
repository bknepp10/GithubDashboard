defmodule GithubDash.Repo do
  use Ecto.Repo,
    otp_app: :github_dash,
    adapter: Ecto.Adapters.Postgres
end
