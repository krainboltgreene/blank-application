
  @doc """
  Returns the list of <%= schema.plural %>.

  ## Examples

      iex> list_<%= schema.plural %>()
      [%<%= inspect schema.module %>{}, ...]

  """
  def list_<%= schema.plural %> do
    raise "TODO"
  end

  @doc """
  Gets a single <%= schema.singular %>.

  Raises if the <%= schema.human_singular %> does not exist.

  ## Examples

      iex> get_<%= schema.singular %>!(123)
      %<%= inspect schema.module %>{}

  """
  def get_<%= schema.singular %>!(id), do: raise "TODO"

  @doc """
  Creates a <%= schema.singular %>.

  ## Examples

      iex> create_<%= schema.singular %>(%{field: value})
      {:ok, %<%= inspect schema.module %>{}}

      iex> create_<%= schema.singular %>(%{field: bad_value})
      {:error, ...}

  """
  def create_<%= schema.singular %>(attrs \\ %{}) do
    raise "TODO"
  end

  @doc """
  Updates a <%= schema.singular %>.

  ## Examples

      iex> update_<%= schema.singular %>(<%= schema.singular %>, %{field: new_value})
      {:ok, %<%= inspect schema.module %>{}}

      iex> update_<%= schema.singular %>(<%= schema.singular %>, %{field: bad_value})
      {:error, ...}

  """
  def update_<%= schema.singular %>(%<%= inspect schema.module %>{} = <%= schema.singular %>, attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a <%= inspect schema.module %>.

  ## Examples

      iex> delete_<%= schema.singular %>(<%= schema.singular %>)
      {:ok, %<%= inspect schema.module %>{}}

      iex> delete_<%= schema.singular %>(<%= schema.singular %>)
      {:error, ...}

  """
  def delete_<%= schema.singular %>(%<%= inspect schema.module %>{} = <%= schema.singular %>) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking <%= schema.singular %> changes.

  ## Examples

      iex> change_<%= schema.singular %>(<%= schema.singular %>)
      %Todo{...}

  """
  def change_<%= schema.singular %>(%<%= inspect schema.module %>{} = <%= schema.singular %>, _attrs \\ %{}) do
    raise "TODO"
  end
