defmodule HenosisWeb.Graphql.Mutations.Session do
  use Absinthe.Schema.Notation

  input_object :new_session do
    field :email, non_null(:string)
    field :password, non_null(:string)
  end

  object :session_mutations do
    @desc "Create a new session"
    field :create_session, :session do
      arg(:input, non_null(:new_session))

      resolve(&HenosisWeb.Graphql.Resolvers.Sessions.create/3)
      middleware(&HenosisWeb.Graphql.Middlewares.Sessions.update_session_id/2)
    end

    @desc "Permanently delete an existing session"
    field :destroy_session, :session do
      middleware(&HenosisWeb.Graphql.Middlewares.Sessions.require_authentication/2)
      resolve(&HenosisWeb.Graphql.Resolvers.Sessions.create/3)
      middleware(&HenosisWeb.Graphql.Middlewares.Sessions.update_session_id/2)
    end
  end
end
