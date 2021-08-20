defmodule Tofu.Config do
  use Skogsra

  @envdoc "IRC host addres for tofu bot."
  app_env :irc_host, :tofu, [:irc, :host], default: "irc.libera.chat"

  @envdoc """
  IRC port for server for tofu bot to
  connect to.
  """
  app_env :irc_port, :tofu, [:irc, :port],
    default: 6667,
    type: :pos_integer

  @envdoc """
  Password for IRC bot. Default value is empty string.
  If your account for IRC bot require to use password
  for authentication, you can provide it.
  """
  app_env :irc_pass, :tofu, :pass, default: ""

  @envdoc "IRC Nickname for bot."
  app_env :irc_nick, :tofu, :nick, default: "tofu[b]"

  @envdoc "IRC username for bot."
  app_env :irc_user, :tofu, :user, default: "tofu[b]"

  @envdoc "IRC full name for bot."
  app_env :irc_name, :tofu, :name, default: "Tofu Bot"

  @envdoc """
  HTTP port that tofu http server will listen at.
  """
  app_env :http_port, :tofu, [:http, :port],
    default: 8080,
    type: :pos_integer

  @envdoc """
  List of channels for bot to join.
  """
  app_env :join_channels, :tofu, [:join, :channels],
    default: ["#hakierspejs", "#hakierspejs-machines"],
    type: Tofu.Config.Types.StringList

  @envdoc """
  List of channels that will be used when /ping webhook
  will be reached. It can not contains items that are not
  present in the :ping_channels list.
  """
  app_env :ping_channels, :tofu, [:ping, :channels],
    default: ["#hakierspejs", "#hakierspejs-machines"],
    type: Tofu.Config.Types.StringList
end
