defmodule CoffeeMachine.CoffeeMachine do
  alias CoffeeMachine.{Order, DrinkMaker}

  @doc """
  Put new order to Coffee Machine

  ## Examples

      iex> alias CoffeeMachine.{Order, CoffeeMachine}
      iex> {:ok, coffee} = Order.new(:coffee, 1)
      iex> CoffeeMachine.put_order(coffee, 1.0)
      "C:1:1 done!"

      iex> alias CoffeeMachine.{Order, CoffeeMachine}
      iex> {:ok, chocolate_sugar_free} = Order.new(:chocolate, 0)
      iex> CoffeeMachine.put_order(chocolate_sugar_free, 1.0)
      "H:: done!"

      iex> alias CoffeeMachine.{Order, CoffeeMachine}
      iex> {:ok, coffee} = Order.new(:coffee, 1)
      iex> CoffeeMachine.put_order(coffee, 0.5)
      "Not enough money!"

  """
  def put_order(%Order{} = order, money) do
    order
    |> format_for_drink_maker()
    |> DrinkMaker.process_command(money)
    |> parse_received_message()
  end

  defp parse_received_message(message) do
    message
    |> String.split(":", parts: 2)
    |> process_message()
  end

  defp process_message(["M", message]), do: message

  defp format_for_drink_maker(%Order{} = order) do
    "#{serialize_order_type(order)}:#{serialize_quantity(order.sugar)}:#{serialize_quantity(order.sticks)}"
  end

  defp serialize_order_type(%Order{type: type, sugar: _sugar, sticks: _sticks}) do
    case type do
      :coffee -> "C"
      :tea -> "T"
      :chocolate -> "H"
    end
  end

  defp serialize_quantity(n), do: if n > 0, do: Integer.to_string(n), else: ""

end
