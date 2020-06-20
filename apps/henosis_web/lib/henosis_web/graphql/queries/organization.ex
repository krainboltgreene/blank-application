defmodule HenosisWeb.Graphql.Queries.Organization do
  use Absinthe.Schema.Notation

  object :organization_queries do
    @desc "Get all organizations"
    field :organizations, list_of(:organization) do
      resolve(&HenosisWeb.Graphql.Resolvers.Organizations.list/3)
    end

    @desc "Get an organization by id"
    field :organization, :organization do
      arg(:id, non_null(:id))

      resolve(&HenosisWeb.Graphql.Resolvers.Organizations.find/3)
    end
  end
end
