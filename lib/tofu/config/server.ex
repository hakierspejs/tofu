defmodule Tofu.Config.Server do
  import Tofu.Config.Utils

  def read() do
    %{
      :port => must_read(&Tofu.Config.http_port/0)
    }
  end
end
