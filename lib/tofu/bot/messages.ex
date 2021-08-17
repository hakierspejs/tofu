defmodule Tofu.Bot.Messages do
  @moduledoc """
  Messages module provides function for replying to
  IRC commands sent by users on the same channel as bot.
  """

  def reply([",?"]) do
    {:ok, "push, p, get, g, del, d, ping, dupa"}
  end

  def reply([",dupa"]) do
    raise :dangerous_exception
  end

  def reply([",ping"]) do
    {:ok, "pong"}
  end

  def reply([",push"]),
    do: {
      :ok,
      "you have to provide some key and value"
    }

  def reply([",push", key]) do
    {:ok, "you have to provide some value"}
  end

  def reply([",push", key, value]) do
    :ok = CubDB.put(Tofu.DB, key, value)

    {:ok, "Saved value for #{key}."}
  end

  def reply([",push" | [key | rest]]) do
    reply([",push", key, Enum.join(rest, " ")])
  end

  def reply([",get", key]) do
    case CubDB.get(Tofu.DB, key) do
      nil ->
        {:ok, "there is no value for #{key}"}

      val ->
        {:ok, val}
    end
  end

  def reply([",get"]),
    do: {
      :ok,
      "you have to provide some key as argument"
    }

  def reply([",del", key]) do
    case CubDB.delete(Tofu.DB, key) do
      :ok ->
        {:ok, "value for #{key} has been deleted"}

      _ ->
        {:ok, "there is no value for #{key}"}
    end
  end

  def reply([",del"]),
    do: {
      :ok,
      "you have to provide some key as argument"
    }

  def reply([",g" | rest]), do: reply([",get"] ++ rest)

  def reply([",p" | rest]), do: reply([",push"] ++ rest)

  def reply([",d" | rest]), do: reply([",del"] ++ rest)

  def reply(_) do
    {:error, :unknown_message}
  end
end
