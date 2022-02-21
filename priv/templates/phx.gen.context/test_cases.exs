
  describe "<%= schema.plural %>" do
    import <%= inspect context.module %>Fixtures

    @invalid_attrs <%= Mix.Phoenix.to_text for {key, _} <- schema.params.create, into: %{}, do: {key, nil} %>

    test "list_<%= schema.plural %>/0 returns all <%= schema.plural %>" do
      <%= schema.singular %> = <%= schema.singular %>_fixture()
      assert <%= inspect context.module %>.list_<%= schema.plural %>() == [<%= schema.singular %>]
    end

    test "get_<%= schema.singular %>!/1 returns the <%= schema.singular %> with given id" do
      <%= schema.singular %> = <%= schema.singular %>_fixture()
      assert <%= inspect context.module %>.get_<%= schema.singular %>!(<%= schema.singular %>.id) == <%= schema.singular %>
    end

    test "create_<%= schema.singular %>/1 with valid data creates a <%= schema.singular %>" do
      valid_attrs = <%= Mix.Phoenix.to_text schema.params.create %>

      assert {:ok, %<%= inspect schema.module %>{} = <%= schema.singular %>} = <%= inspect context.module %>.create_<%= schema.singular %>(valid_attrs)<%= for {field, value} <- schema.params.create do %>
      assert <%= schema.singular %>.<%= field %> == <%= Mix.Phoenix.Schema.value(schema, field, value) %><% end %>
    end

    test "create_<%= schema.singular %>/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = <%= inspect context.module %>.create_<%= schema.singular %>(@invalid_attrs)
    end

    test "update_<%= schema.singular %>/2 with valid data updates the <%= schema.singular %>" do
      <%= schema.singular %> = <%= schema.singular %>_fixture()
      update_attrs = <%= Mix.Phoenix.to_text schema.params.update%>

      assert {:ok, %<%= inspect schema.module %>{} = <%= schema.singular %>} = <%= inspect context.module %>.update_<%= schema.singular %>(<%= schema.singular %>, update_attrs)<%= for {field, value} <- schema.params.update do %>
      assert <%= schema.singular %>.<%= field %> == <%= Mix.Phoenix.Schema.value(schema, field, value) %><% end %>
    end

    test "update_<%= schema.singular %>/2 with invalid data returns error changeset" do
      <%= schema.singular %> = <%= schema.singular %>_fixture()
      assert {:error, %Ecto.Changeset{}} = <%= inspect context.module %>.update_<%= schema.singular %>(<%= schema.singular %>, @invalid_attrs)
      assert <%= schema.singular %> == <%= inspect context.module %>.get_<%= schema.singular %>!(<%= schema.singular %>.id)
    end

    test "delete_<%= schema.singular %>/1 deletes the <%= schema.singular %>" do
      <%= schema.singular %> = <%= schema.singular %>_fixture()
      assert {:ok, %<%= inspect schema.module %>{}} = <%= inspect context.module %>.delete_<%= schema.singular %>(<%= schema.singular %>)
      assert_raise Ecto.NoResultsError, fn -> <%= inspect context.module %>.get_<%= schema.singular %>!(<%= schema.singular %>.id) end
    end

    test "change_<%= schema.singular %>/1 returns a <%= schema.singular %> changeset" do
      <%= schema.singular %> = <%= schema.singular %>_fixture()
      assert %Ecto.Changeset{} = <%= inspect context.module %>.change_<%= schema.singular %>(<%= schema.singular %>)
    end
  end
