defmodule Tofu.Bot.ConnectionHandler do
  use GenServer

  defmodule State do
    defstruct host: "irc.libera.chat",
              port: 6667,
              pass: "",
              nick: "",
              user: "",
              name: "",
              client: nil,
              client_proc: nil,
              handlers: [],
              messages_service: nil
  end

  def start_link(state) do
    GenServer.start_link(
      __MODULE__,
      [%State{state | :client => Tofu.Bot.Factory.retrieve(state.client_proc)}],
      name: __MODULE__
    )
  end

  def init([state]) do
    ExIRC.Client.add_handler(state.client, self)
    ExIRC.Client.connect!(state.client, state.host, state.port)
    {:ok, state}
  end

  def handle_info({:connected, server, port}, state) do
    debug("Connected to #{server}:#{port}")
    ExIRC.Client.logon(state.client, state.pass, state.nick, state.user, state.name)
    {:noreply, state}
  end

  def handle_info({:received, msg, _, channel}, state) do
    case state.messages_service.reply(String.split(msg, " ")) do
      {:ok, response} ->
        ExIRC.Client.msg(state.client, :privmsg, channel, response)

      {:error, :unknown_message} ->
        debug("Received unknown command:")
        IO.inspect(msg)

      response ->
        debug("Received unknown response:")
        IO.inspect(response)
        IO.inspect(msg)
        IO.inspect(String.split(msg, " "))
    end

    {:noreply, state}
  end

  # Catch-all for messages you don't care about
  def handle_info(msg, state) do
    debug("Received unknown messsage:")
    IO.inspect(msg)
    {:noreply, state}
  end

  defp debug(msg) do
    IO.puts(IO.ANSI.yellow() <> msg <> IO.ANSI.reset())
  end
end
