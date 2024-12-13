defmodule GithubDash.GithubUsersTest do
  use GithubDash.DataCase

  alias GithubDash.GithubUsers

  describe "users" do
    alias GithubDash.GithubUsers.User

    import GithubDash.GithubUsersFixtures

    @invalid_attrs %{name: nil, repos: nil, url: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert GithubUsers.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert GithubUsers.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{name: "some name", repos: "some repos", url: "some url"}

      assert {:ok, %User{} = user} = GithubUsers.create_user(valid_attrs)
      assert user.name == "some name"
      assert user.repos == "some repos"
      assert user.url == "some url"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GithubUsers.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        name: "some updated name",
        repos: "some updated repos",
        url: "some updated url"
      }

      assert {:ok, %User{} = user} = GithubUsers.update_user(user, update_attrs)
      assert user.name == "some updated name"
      assert user.repos == "some updated repos"
      assert user.url == "some updated url"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = GithubUsers.update_user(user, @invalid_attrs)
      assert user == GithubUsers.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = GithubUsers.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> GithubUsers.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = GithubUsers.change_user(user)
    end
  end
end
