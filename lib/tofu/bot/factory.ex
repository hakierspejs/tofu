defmodule Tofu.Bot.Factory do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    {:ok, client} = ExIRC.start_link!()
    {:ok, client}
  end

  @impl true
  def handle_call(:retrieve, _from, client) do
    {:reply, client, client}
  end

  @doc """
  Returns current instance of ExIRC client.
  """
  def retrieve(server) do
    GenServer.call(server, :retrieve)
  end
end
