defmodule CoffeeMachine.DrinkMaker do

  @doc """
  Process command

  ## Examples

      iex> alias CoffeeMachine.DrinkMaker
      iex> DrinkMaker.process_command("C:1:1")
      "M:C:1:1 done!"

  """
  def process_command(command) do
    "M:#{command} done!"
  end
end
