defmodule BankAccount do
  def start do
    await([])
  end

  def await(events) do
    events = receive do
      {:check_balance, pid} -> divulge_balance(pid, events)
      {:deposit, amount}    -> deposit(amount, events)
      {:withdraw, amount}   -> withdraw(amount, events)
    end
    await(events)
  end

  defp deposit(amount, events) do
    events ++ [{:deposit, amount}]
  end

  defp withdraw(amount, events) do
    events ++ [{:withdraw, amount}]
  end

  defp divulge_balance(pid, events) do
    Process.send pid, {:balance, calculate_balance(events)}, []
  end

  defp calculate_balance(events) do
    deposits = sum(just_deposits(events))
    withdrawals = sum(just_withdrawals(events))
    deposits - withdrawals
  end

  defp just_type(events, expected_type) do
    Enum.filter(events, fn({type, _}) -> type == expected_type end)
  end

  def just_deposits(events) do
    just_type(events, :deposit)
  end

  def just_withdrawals(events) do
    just_type(events, :withdraw)
  end

  defp sum(events) do
    Enum.reduce(events, 0, fn({_, amount}, acc) -> acc + amount end)
  end
end
