defmodule Tofu.Config.Bot do
  import Tofu.Config.Utils

  def read() do
    %{
      :connection => %Tofu.Bot.ConnectionHandler.State{
        :host => must_read(&Tofu.Config.irc_host/0),
        :port => must_read(&Tofu.Config.irc_port/0),
        :pass => must_read(&Tofu.Config.irc_pass/0),
        :nick => must_read(&Tofu.Config.irc_nick/0),
        :user => must_read(&Tofu.Config.irc_user/0),
        :name => must_read(&Tofu.Config.irc_name/0),
        :handlers => [],
        :client_proc => :irc_client,
        :client => nil,
        :messages_service => Tofu.Bot.Messages
      }
    }
  end
end
