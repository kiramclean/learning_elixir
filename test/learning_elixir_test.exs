defmodule LearningElixirTest do
  use ExUnit.Case
  doctest LearningElixir

  test "uppercase doesn't change the first word" do
    assert(LearningElixir.uppercase("foo") == "foo")
  end

  test "uppercase converts the second word to uppercase" do
    assert(LearningElixir.uppercase("foo bar") == "foo BAR")
  end

  test "uppercase converts every other word to uppercase" do
    assert(LearningElixir.uppercase("foo bar baz whee") == "foo BAR baz WHEE")
  end

  test "unvowel doesn't change the first word" do
    assert(LearningElixir.unvowel("foo") == "foo")
  end

  test "unvowel converts the second word to unvowel" do
    assert(LearningElixir.unvowel("foo bar") == "foo br")
  end

  test "unvowel converts every other word to unvowel" do
    assert(LearningElixir.unvowel("foo bar baz whee") == "foo br baz wh")
  end
end
