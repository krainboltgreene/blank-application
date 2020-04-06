defmodule BlankWeb.Graphql.Subscriptions.Account do
  use Absinthe.Schema.Notation

  object :account_subscriptions do
    @desc "When a new account is created"
    field :account_created, :account do
      arg(:id, non_null(:id))

      # The topic function is used to determine what topic a given subscription
      # cares about based on its arguments.
      config(fn args, _ ->
        {:ok, topic: args.id}
      end)

      # This tells Absinthe to run any subscriptions with this field every time
      # the mutation happens. It also has a topic function used to find what
      # subscriptions care about this particular comment.
      trigger(:create_account,
        topic: fn account ->
          account.id
        end
      )
    end
  end
end
