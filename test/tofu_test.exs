defmodule TofuTest do
  use ExUnit.Case
  doctest Tofu

  test "greets the world" do
    assert Tofu.hello() == :world
  end
end
