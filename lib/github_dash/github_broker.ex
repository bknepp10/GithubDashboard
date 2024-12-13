defmodule GithubDash.GithubBroker do
  use GenServer
  require Logger

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    # Delay the API call for a short time to ensure the app starts fully
    Process.send_after(self(), :fetch_users, 1000)
    {:ok, %{}}
  end

  def handle_info(:fetch_users, state) do
    fetch_and_save_users()
    {:noreply, state}
  end

  defp fetch_and_save_users do
    url = "https://api.github.com/users"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        users = Jason.decode!(body)

        Enum.each(users, fn user ->
          Logger.info("Fetched user: #{user["login"]}")
          # Optionally insert into DB
          format_git_user(user)
          |> GithubDash.GithubUsers.create_user()
        end)

      {:ok, %HTTPoison.Response{status_code: code}} ->
        Logger.error("Failed to fetch users: Status code #{code}")

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Failed to fetch users: #{reason}")
    end
  end

  def format_git_user(user) do
    fetch_and_count_user_repos(user)

    %{
      name: user["login"],
      repos_url: user["repos_url"],
      html_url: user["html_url"],
      avatar_url: user["avatar_url"],
      repos_count: fetch_and_count_user_repos(user)
    }
  end

  def fetch_and_count_user_repos(user) do
    case HTTPoison.get(user["repos_url"]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        repos = Jason.decode!(body)
        # Count the number of repositories
        length(repos)

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.puts("Error fetching repositories: #{reason}")
        # Return 0 if there's an error
        0
    end
  end
end
