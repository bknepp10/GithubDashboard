defmodule GithubDash.GithubUsers.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :repos_url, :string
    field :html_url, :string
    field :avatar_url, :string
    field :repos_count, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :repos_url, :html_url, :avatar_url, :repos_count])
    |> validate_required([:name, :repos_url, :html_url, :avatar_url, :repos_count])
  end
end
