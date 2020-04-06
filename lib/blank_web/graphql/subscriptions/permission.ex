defmodule BlankWeb.Graphql.Subscriptions.Permission do
  use Absinthe.Schema.Notation

  object :permission_subscriptions do
    @desc "When a new permission is created"
    field :permission_created, :permission do
      arg(:id, non_null(:id))

      # The topic function is used to determine what topic a given subscription
      # cares about based on its arguments.
      config(fn args, _ ->
        {:ok, topic: args.id}
      end)

      # This tells Absinthe to run any subscriptions with this field every time
      # the mutation happens. It also has a topic function used to find what
      # subscriptions care about this particular comment.
      trigger(:create_permission,
        topic: fn permission ->
          permission.id
        end
      )
    end
  end
end
