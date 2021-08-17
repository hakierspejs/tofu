defmodule Tofu.Bot.Supervisor do
  @moduledoc false

  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    {:ok, client} = ExIRC.start_link!()

    children = [
      {Tofu.Bot.Factory, [name: :irc_client]},

      # Define workers and child supervisors to be supervised
      {Tofu.Bot.ConnectionHandler,
       %Tofu.Bot.ConnectionHandler.State{
         :host => "irc.libera.chat",
         :port => 6667,
         :pass => "",
         :nick => "tofu[b]",
         :user => "tofu[b]",
         :name => "Tofu Bot",
         :handlers => [],
         :client_proc => :irc_client,
         :client => nil,
         :messages_service => Tofu.Bot.Messages
       }},

      # Here's where we specify the channels to join
      {Tofu.Bot.LoginHandler, [:irc_client, ["#hakierspejs-machines"]]}
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end
