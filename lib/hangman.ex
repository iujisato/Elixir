defmodule Hangman do

# iex> Benchmark.measure(fn -> Hangman.game1(600_000) end)
# 11.394374
# 11.410963
# 11.473353
  def game1(remaining_chances) do
    cond do
      remaining_chances <= 0 ->
        IO.puts "Você perdeu!"
      true ->
        IO.puts remaining_chances
        game1(remaining_chances - 1)
    end
  end

# iex> Benchmark.measure(fn -> Hangman.game2(600_000) end)
# 11.496644
# 11.318567
# 11.511055
  def game2(remaining_chances) when remaining_chances > 0 do
    IO.puts remaining_chances
    game2(remaining_chances - 1)
  end

  def game2(remaining_chances) when remaining_chances <= 0 do
    IO.puts "Você perdeu!"
  end

# iex> Benchmark.measure(fn -> Hangman.game3(600_000) end)
# 11.306187
# 11.613859
# 11.370993
  def game3(remaining_chances) do
    case remaining_chances do
      remaining_chances when remaining_chances <= 0 ->
        IO.puts "Você perdeu!"
      _ ->
        IO.puts remaining_chances
        game3(remaining_chances - 1)
    end
  end

  def keyword do
    IO.puts("Sua palavra secreta é " <> get_keyword)
  end

  defp get_keyword do
    IO.gets "Tell me a secret keyword! "
  end
end
