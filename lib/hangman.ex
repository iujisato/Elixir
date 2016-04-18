defmodule Hangman do
  def game(remaining_chances) when remaining_chances > 0 do
    IO.puts remaining_chances
    game(remaining_chances - 1)
  end

  def game(remaining_chances) when remaining_chances <= 0 do
    IO.puts "Você perdeu!"
  end

  def keyword do
    IO.puts("Sua palavra secreta é " <> get_keyword)
  end

  defp get_keyword do
    IO.gets "Tell me a secret keyword! "
  end
end
