defmodule <%= inspect context.web_module %>.<%= inspect Module.concat(schema.web_namespace, schema.alias) %>Live.Index do
  @moduledoc false
  use <%= inspect context.web_module %>, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :<%= schema.collection %>, list_<%= schema.plural %>())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit <%= schema.human_singular %>")
    |> assign(:<%= schema.singular %>, <%= inspect context.module %>.get_<%= schema.singular %>!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New <%= schema.human_singular %>")
    |> assign(:<%= schema.singular %>, %<%= inspect schema.module %>{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing <%= schema.human_plural %>")
    |> assign(:<%= schema.singular %>, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    <%= schema.singular %> = <%= inspect context.module %>.get_<%= schema.singular %>!(id)
    {:ok, _} = <%= inspect context.module %>.delete_<%= schema.singular %>(<%= schema.singular %>)

    {:noreply, assign(socket, :<%= schema.collection %>, list_<%=schema.plural %>())}
  end

  defp list_<%= schema.plural %> do
    <%= inspect context.module %>.list_<%= schema.plural %>()
  end
end
