defmodule ClumsyChinchilla.Users.AccountNotifier do
  import Swoosh.Email
  alias ClumsyChinchilla.Mailer

  def deliver_onboarding(%{name: name, email: email}) do
    new()
    |> to({name, email})
    |> from({"Phoenix Team", "team@example.com"})
    |> subject("Welcome to Phoenix, #{name}!")
    |> html_body("<h1>Hello, #{name}</h1>")
    |> text_body("Hello, #{name}\n")
    |> Mailer.deliver()
  end
end
