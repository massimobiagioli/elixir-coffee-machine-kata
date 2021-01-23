defmodule CoffeeMachine.CoffeeMachine do
  alias CoffeeMachine.Order

  @doc """
  Put new order to Coffee Machine

  ## Examples

      iex> alias CoffeeMachine.{Order, CoffeeMachine}
      iex> {:ok, coffee} = Order.new(:coffee, 1)
      iex> CoffeeMachine.put_order(coffee)
      "Command: C:1:1 sent to drink maker"

      iex> alias CoffeeMachine.{Order, CoffeeMachine}
      iex> {:ok, chocolate_sugar_free} = Order.new(:chocolate, 0)
      iex> CoffeeMachine.put_order(chocolate_sugar_free)
      "Command: H:: sent to drink maker"

  """
  def put_order(%Order{} = order) do
    order
    |> format_for_drink_maker()
    |> send_to_drink_maker()
  end

  @doc """
  Receive message from drink maker

  ## Examples

      iex> alias CoffeeMachine.CoffeeMachine
      iex> CoffeeMachine.receive_message("M:Coffee with one sugar")
      "Coffee with one sugar"

  """
  def receive_message(message) do
    message
    |> String.split(":")
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

  defp send_to_drink_maker(command) do
    "Command: #{command} sent to drink maker"
  end

end
