defmodule GithubDash.GithubUsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GithubDash.GithubUsers` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "some name",
        repos: "some repos",
        url: "some url"
      })
      |> GithubDash.GithubUsers.create_user()

    user
  end
end
