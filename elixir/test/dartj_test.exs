defmodule DartjTest do
  use ExUnit.Case
  doctest Dartj

  test "greets the world" do
    assert Dartj.hello() == :world
  end
end
