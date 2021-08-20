defmodule Tofu.Config.Utils do
  def must_read(fun) do
    {:ok, val} = fun.()
    val
  end
end
