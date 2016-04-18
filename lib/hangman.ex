defmodule Hangman do
  # iex> Benchmark.measure(fn -> Hangman.game2(600_000) end)
  # 11.215590
  # 11.312048
  # 11.276873

  # def right_word? do
  #   remaining_letters(word, right_guesses).empty?
  # end

  # Returns keyword mapset with characters
  # Hangman.keyword_letters
  # Tell me a secret keyword! Banana
  # MapSet<["B", "a", "n"]>
  def keyword_letters do
    keyword = IO.gets "Tell me a secret keyword! "
    blocked_chars = MapSet.new(["", "\n", " "])

    String.split(keyword, "", trim: true)
      |> MapSet.new
      |> MapSet.difference(blocked_chars)
  end

  def guesses do
    MapSet.new
  end

  def game2(0, _, _) do
    IO.puts "Você perdeu!"
  end

  def game2(remaining_chances, guesses) do
    game2((remaining_chances - 1), guesses)
  end

  # iex> Benchmark.measure(fn -> Hangman.game1(600_000) end)
  # 11.394374
  # 11.410963
  # 11.473353
  # def game1(remaining_chances) do
  #   cond do
  #     remaining_chances <= 0 ->
  #       IO.puts "Você perdeu!"
  #     true ->
  #       IO.puts remaining_chances
  #       game1(remaining_chances - 1)
  #   end
  # end

  # iex> Benchmark.measure(fn -> Hangman.game3(600_000) end)
  # 11.306187
  # 11.613859
  # 11.370993
  # def game3(remaining_chances) do
  #   case remaining_chances do
  #     remaining_chances when remaining_chances <= 0 ->
  #       IO.puts "Você perdeu!"
  #     _ ->
  #       IO.puts remaining_chances
  #       game3(remaining_chances - 1)
  #   end
  # end
end
