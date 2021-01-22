defmodule CoffeeMachineKataTest do
  use ExUnit.Case
  doctest CoffeeMachineKata

  test "greets the world" do
    assert CoffeeMachineKata.hello() == :world
  end
end
