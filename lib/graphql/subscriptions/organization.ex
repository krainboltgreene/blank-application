defmodule Graphql.Subscriptions.Organization do
  use Absinthe.Schema.Notation

  object :organization_subscriptions do
    @desc "When a new organization is created"
    field :organization_created, :organization do
      arg(:id, non_null(:id))

      # The topic function is used to determine what topic a given subscription
      # cares about based on its arguments.
      config(fn args, _ ->
        {:ok, topic: args.id}
      end)

      # This tells Absinthe to run any subscriptions with this field every time
      # the mutation happens. It also has a topic function used to find what
      # subscriptions care about this particular comment.
      trigger(:create_organization,
        topic: fn organization ->
          organization.id
        end
      )
    end
  end
end
