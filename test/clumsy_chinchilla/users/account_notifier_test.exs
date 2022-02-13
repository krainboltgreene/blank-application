defmodule ClumsyChinchilla.Users.AccountNotifierTest do
  use ExUnit.Case, async: true
  import Swoosh.TestAssertions

  test "deliver_onboarding/1" do
    user = %{name: "Alice", email: "alice@example.com"}

    AccountNotifier.deliver_onboarding(user)

    assert_email_sent(
      subject: "Welcome to Phoenix, Alice!",
      to: {"Alice", "alice@example.com"},
      text_body: ~r/Hello, Alice/
    )
  end
end
