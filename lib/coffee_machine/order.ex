defmodule CoffeeMachine.Order do
  alias __MODULE__

  @enforce_keys [:type, :sugar, :sticks]
  defstruct [:type, :sugar, :sticks]

  @types [:coffee, :tea, :chocolate]
  @sugar_range 0..2

  @doc """
  Create new order

  ## Examples

      iex> alias CoffeeMachine.Order
      iex> Order.new(:hamburger, 1)
      {:error, :invalid_type}

      iex> alias CoffeeMachine.Order
      iex> Order.new(:coffee, 4)
      {:error, :invalid_sugar}

      iex> alias CoffeeMachine.Order
      iex> Order.new(:coffee, 1)
      {:ok, %CoffeeMachine.Order{sticks: 1, sugar: 1, type: :coffee}}

  """
  def new(type, _sugar) when type not in(@types), do: {:error, :invalid_type}

  def new(_type, sugar) when sugar not in(@sugar_range), do: {:error, :invalid_sugar}

  def new(type, sugar), do:
    {:ok, %Order{type: type, sugar: sugar, sticks: sticks(sugar)}}

  defp sticks(sugar), do: if sugar > 0, do: 1, else: 0

end
