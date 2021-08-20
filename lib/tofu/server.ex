defmodule Tofu.Server do
  use Plug.Router

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch, builder_opts)

  get "/ping" do
    client = Tofu.Bot.Factory.retrieve(:irc_client)

    {:ok, channels} = Tofu.Config.ping_channels()

    channels
    |> Enum.map(
      &ExIRC.Client.msg(
        client,
        :privmsg,
        &1,
        "I've got ping from http webhook."
      )
    )

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(
      200,
      Jason.encode!(%{
        "version" => Tofu.MixProject.project()[:version]
      })
    )
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
