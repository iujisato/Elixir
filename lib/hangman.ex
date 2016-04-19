defmodule Hangman do
  # iex> Benchmark.measure(fn -> Hangman.game2(600_000) end)
  # 11.215590
  # 11.312048
  # 11.276873

  # Returns keyword mapset with characters
  # Hangman.keyword_letters
  # Tell me a secret keyword! Banana
  # MapSet<["B", "a", "n"]>
  def keyword_letters(keyword) do
    blocked_chars = MapSet.new(["", "\n", " "])

    String.split(String.upcase(keyword), "")
      |> MapSet.new
      |> MapSet.difference(blocked_chars)
  end

  # (defn feedback-interface [remaining-chances word right-guesses]
  #   (println "Remaining chances:" remaining-chances)
  #   (doseq [character (seq word)]
  #   (if (contains? right-guesses (str character))
  #       (print character " ")
  #       (print "_" " ")))
  #   (println))

  def feedback_interface(remaining_chances, keyword, right_guesses) do
    IO.puts "Remaining chances: #{remaining_chances}"

    cond do
    MapSet.disjoint?(keyword_letters(keyword), right_guesses) ->
      guess_list = keyword_letters(keyword)
                     |> MapSet.to_list

      keyword_feedback = String.replace(keyword, guess_list, "_")
      IO.puts keyword_feedback

    true ->
      guess_mapset = MapSet.difference(keyword_letters(keyword), right_guesses)

      if MapSet.size(guess_mapset) > 0 do
          guess_list = MapSet.to_list(guess_mapset)
          keyword_feedback = String.replace(keyword, guess_list, "_")
          IO.puts keyword_feedback
      else
          IO.puts keyword
      end
    end
  end


  def game2(0, _, _) do
    IO.puts "Você perdeu!"
  end

  def game2(remaining_chances, keyword, right_guesses) do
    feedback_interface(remaining_chances, keyword, right_guesses)
    cond do
      MapSet.equal?(right_guesses, keyword_letters(keyword)) ->
        IO.puts "Você ganhou!"

      true ->
        guess = String.strip(IO.gets "chuta aí ")
                  |> String.upcase
        if MapSet.member?(keyword_letters(keyword), guess) do
          IO.puts "Acertou mizeráavi"
          game2(remaining_chances, keyword, MapSet.put(right_guesses, guess))
        else
          IO.puts "Errou"
          game2((remaining_chances - 1), keyword, right_guesses)
        end
    end
  end

  def game do
    game2(3, "OVO BRANCO", MapSet.new)
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
