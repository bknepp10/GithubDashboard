defmodule GithubDash.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :repos_url, :string
      add :html_url, :string
      add :avatar_url, :string
      add :repos_count, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
