defmodule LearningElixir do
  @moduledoc """
  A module used for learning elixir! [ElixirSips](http://www.elixirsips.com) is awesome.
  """

  @doc """
  Uppercases every other word in a sentence. Example:

  iex> LearningElixir.uppercase("this is awesome")
  "this IS awesome"
  """
  def uppercase(string) do
    transform_every_other_word(string, &uppercaser/1)
  end

  @doc """
  Removes vowels from every other word in a sentence. Example:

  iex> LearningElixir.unvowel("this is awesome")
  "this s awesome"
  """
  def unvowel(string) do
    transform_every_other_word(string, &unvoweler/1)
  end

  def transform_every_other_word(string, transformation) do
    words = String.split(string)

    words_with_index = Stream.with_index(words)
    transformed_words = Enum.map(words_with_index, transformation)

    Enum.join(transformed_words, " ")
  end

  def uppercaser(input) do
    transformer(input, &String.upcase/1)
  end

  def unvoweler(input) do
    transformer(input, fn (word) -> Regex.replace(~r([aeiou]), word, "") end)
  end

  def transformer({word, index}, transformation) do
    cond do
      rem(index, 2) == 0 -> word
      rem(index, 2) == 1 -> transformation.(word)
    end
  end
end
