defmodule GithubDashWeb.UserCardComponent do
  use Phoenix.Component

  def user_card(assigns) do
    {_test, user} = assigns
    IO.inspect(user, label: "assigns")
    # {_user_id, user} = assigns
    # assigns = assign(assigns, {:user, user})

    ~H"""
    <div class="card bg-base-300 w-96 shadow-xl">
      <div class="avatar">
        <div class="w-24 rounded-full">
          <img src={@user.avatar_url} />
        </div>
      </div>
      
      <%!-- <figure class="px-10 pt-10">
        <img src={@user.avatar_url} alt="User Avatar" class="rounded-xl" />
      </figure> --%>
      <div class="card-body items-center text-center">
        <h2 class="card-title"><%= @user.name %></h2>
         <%!-- <p>If a dog chews shoes whose shoes does he choose?</p> --%>
        <%!-- <div class="card-actions justify-end">
          <button class="btn btn-primary">Buy Now</button>
        </div> --%>
      </div>
    </div>
    """

    # ~H"""
    # <!-- Profile Card Container -->
    # <div class="card w-96 bg-base-100 shadow-xl">
    #   <div class="card-body items-center text-center">
    #     <!-- User Avatar -->
    #     <div class="avatar">
    #       <div class="w-24 rounded-full ring ring-primary ring-offset-base-100 ring-offset-2 mb-4">
    #         <img src={@user.avatar_url} alt="User Avatar" />
    #       </div>
    #     </div>
    #     <!-- Username -->
    #     <h2 class="card-title text-lg font-bold">
    #       <%= @user.name %>
    #     </h2>
    #     <!-- Number of Repositories -->
    #     <p class="text-gray-500">
    #       Repositories: <strong><%= @user.repos_count %></strong>
    #     </p>
    #     <!-- GitHub Profile Link -->
    #     <div class="card-actions mt-4">
    #       <a href={@user.html_url} target="_blank" class="btn btn-primary">
    #         View Profile
    #       </a>
    #     </div>
    #   </div>
    # </div>
    # """
  end
end
