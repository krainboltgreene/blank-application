defmodule Web.Router do
  use Web, :router
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {Web.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    # TODO: Replace with application config
    plug CORSPlug,
      origin: [
        "http://localhost:8000",
        "http://localhost:8080",
        "https://studio.apollographql.com"
      ]

    plug :fetch_session
  end

  pipeline :graphql do
    plug HenosisWeb.Plugs.GraphqlSessionContext
  end

  # Other scopes may use custom stacks.
  scope "/" do
    pipe_through :browser

    # get "/", Web.PageController, :index

    # live "/", PageLive, :index
    if Mix.env() != :prod do
      # If using Phoenix
      forward "/sent_emails", Bamboo.SentEmailViewerPlug

      # Enables LiveDashboard only for development
      #
      # If you want to use the LiveDashboard in production, you should put
      # it behind authentication and allow only admins to access it.
      # If your application does not have an admins-only section yet,
      # you can use Plug.BasicAuth to set up some basic authentication
      # as long as you are also using SSL (which you should anyway).
      live_dashboard "/dashboard", metrics: Web.Telemetry
    end

    get "/:path", Web.RemoteController, :browser_remote
  end

  scope "/graphql" do
    pipe_through :api
    pipe_through :graphql

    forward "/",
            Absinthe.Plug,
            schema: Graphql.Schema,
            analyze_complexity: true,
            max_complexity: 200,
            before_send: {Graphql.Middlewares.Sessions, :absinthe_before_send}
  end
end
