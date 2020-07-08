defmodule Graphql.Schema do
  use Absinthe.Schema
  # import AbsintheErrorPayload.Payload

  import_types(AbsintheErrorPayload.ValidationMessageTypes)

  import_types(Absinthe.Type.Custom)

  import_types(Graphql.Types.Account)
  import_types(Graphql.Types.Permission)
  import_types(Graphql.Types.Organization)
  import_types(Graphql.Types.Session)

  import_types(Graphql.Queries.Account)
  import_types(Graphql.Queries.Permission)
  import_types(Graphql.Queries.Organization)
  import_types(Graphql.Queries.Session)

  import_types(Graphql.Mutations.Account)
  import_types(Graphql.Mutations.Permission)
  import_types(Graphql.Mutations.Organization)
  import_types(Graphql.Mutations.Session)

  import_types(Graphql.Subscriptions.Account)
  import_types(Graphql.Subscriptions.Permission)
  import_types(Graphql.Subscriptions.Organization)
  import_types(Graphql.Subscriptions.Session)

  query do
    import_fields(:account_queries)
    import_fields(:permission_queries)
    import_fields(:organization_queries)
    import_fields(:session_queries)
  end

  mutation do
    import_fields(:account_mutations)
    import_fields(:permission_mutations)
    import_fields(:organization_mutations)
    import_fields(:session_mutations)
  end

  subscription do
    import_fields(:account_subscriptions)
    import_fields(:permission_subscriptions)
    import_fields(:organization_subscriptions)
    import_fields(:session_subscriptions)
  end
end
