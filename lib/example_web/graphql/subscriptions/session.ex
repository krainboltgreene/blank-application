defmodule ClumsyChinchillaWeb.Graphql.Subscriptions.Session do
  use Absinthe.Schema.Notation

  object :session_subscriptions do
    @desc "When a new session is created"
    field :session_created, :session do
      arg(:id, non_null(:id))

      # The topic function is used to determine what topic a given subscription
      # cares about based on its arguments.
      config(fn args, _ ->
        {:ok, topic: args.id}
      end)

      # This tells Absinthe to run any subscriptions with this field every time
      # the mutation happens. It also has a topic function used to find what
      # subscriptions care about this particular comment.
      trigger(:create_session,
        topic: fn session ->
          session.id
        end
      )
    end
  end
end
