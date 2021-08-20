defmodule Tofu.Bot.Supervisor do
  @moduledoc false

  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    {:ok, client} = ExIRC.start_link!()

    {:ok, join_channels} = Tofu.Config.join_channels()

    bot_config = Tofu.Config.Bot.read()

    children = [
      {Tofu.Bot.Factory, [name: :irc_client]},

      # Define workers and child supervisors to be supervised
      {Tofu.Bot.ConnectionHandler, bot_config.connection},

      # Here's where we specify the channels to join
      {Tofu.Bot.LoginHandler, [:irc_client, join_channels]}
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end
