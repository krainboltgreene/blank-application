defmodule Mailer do
  @moduledoc """
  Contains all the core email logic.
  """
  use Bamboo.Mailer, otp_app: :clumsy_chinchilla
  use Bamboo.Phoenix, view: Mailer.EmailView
  import Bamboo.Email

  @default_from_email_address Application.get_env(:clumsy_chinchilla, :reply_email_address)
  @default_replyto_email_address Application.get_env(:clumsy_chinchilla, :reply_email_address)

  def new_application_email() do
    new_email()
    |> from(@default_from_email_address)
    |> put_layout({Mailer.LayoutView, :root})
    |> put_header("Reply-To", @default_replyto_email_address)
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/mailer/templates",
        namespace: Mailer

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  defp view_helpers do
    quote do
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      import Mailer.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
