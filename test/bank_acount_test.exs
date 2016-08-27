defmodule BankAccountTest do
  use ExUnit.Case

  test "starts off with a balance of 0" do
    account = spawn_link(BankAccount, :start, [])
    verify_balance_is 0, account
  end

  test "increments balance by the amount of the deposit" do
    account = spawn_link(BankAccount, :start, [])
    Process.send account, {:deposit, 10}, []
    verify_balance_is 10, account
  end

  test "decrements balance by the amount of the withdrawal" do
    account = spawn_link(BankAccount, :start, [])
    Process.send account, {:deposit, 30}, []
    Process.send account, {:withdraw, 10}, []
    verify_balance_is 20, account
  end

  def verify_balance_is(expected_balance, account) do
    Process.send account, {:check_balance, self}, []
    assert_receive {:balance, ^expected_balance}
  end
end
