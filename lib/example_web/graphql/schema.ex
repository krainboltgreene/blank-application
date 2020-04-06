defmodule ExampleWeb.Graphql.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)

  import_types(ExampleWeb.Graphql.Types.{
    Account,
    Permission,
    Organization,
    Session
  })

  import_types(ExampleWeb.Graphql.Queries.{
    Account,
    Permission,
    Organization,
    Session
  })

  import_types(ExampleWeb.Graphql.Mutations.{
    Account,
    Permission,
    Organization,
    Session
  })

  import_types(ExampleWeb.Graphql.Subscriptions.{
    Account,
    Permission,
    Organization,
    Session
  })

  def middleware(middleware, _field, _object) do
    middleware ++ [Crudry.Middlewares.TranslateErrors]
  end

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
