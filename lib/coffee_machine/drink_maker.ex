defmodule CoffeeMachine.DrinkMaker do

  @prices %{"C" => 0.6, "T" => 0.4, "H" => 0.6}

  @doc """
  Process command

  ## Examples

      iex> alias CoffeeMachine.DrinkMaker
      iex> DrinkMaker.process_command("C:1:1", 1.0)
      "M:C:1:1 done!"

      iex> alias CoffeeMachine.DrinkMaker
      iex> DrinkMaker.process_command("C:1:1", 0.5)
      "M:Not enough money!"

  """
  def process_command(command, money) do
    price = command_to_price(command)
    cond do
      money < price ->
        "M:Not enough money!"
      money >= price ->
        "M:#{command} done!"
    end
  end

  defp command_to_price(command) do
    command
    |> String.split(":", parts: 2)
    |> get_price()
  end

  defp get_price([type, _]), do: Map.get(@prices, type, 0)

end
