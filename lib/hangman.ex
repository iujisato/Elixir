defmodule Hangman do
  @doc ~S"""
  Receives a keyword string and returns a mapset of string characters, excluding
  blocked chars.

  ## Example

      iex> Hangman.keyword_letters("banana")
      #MapSet<["a", "b", "n"]>

      iex> Hangman.keyword_letters("bob sponge")
      #MapSet<["b", "e", "g", "n", "o", "p", "s"]>

  """
  def keyword_letters(keyword) do
    blocked_chars = MapSet.new(["", "\n", " "])

    String.split(keyword, "")
      |> MapSet.new
      |> MapSet.difference(blocked_chars)
  end

  @doc ~S"""
  Receives the current game stats, like "Remaining chances" or "Right guesses"
  and return a visual feedback on console.

  ## Example

      iex> Hangman.feedback_interface(4, "bob sponge", MapSet.new)
      :ok
      # Remaining chances: 4
      # ___ ______

      iex> Hangman.feedback_interface(2, "bob sponge", MapSet.new(["b", "n", "g"]))
      :ok
      # Remaining chances: 2
      # b_b ___ng_


  """
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
    IO.puts "Well, shit happens..."
  end

  def game2(remaining_chances, keyword, right_guesses) do
    keyword = String.upcase(keyword)
    feedback_interface(remaining_chances, keyword, right_guesses)
    cond do
      MapSet.equal?(right_guesses, keyword_letters(keyword)) ->
        IO.puts "Really? gratz bro!"

      true ->
        guess = String.strip(IO.gets "chuta aí ")
                  |> String.upcase
        if MapSet.member?(keyword_letters(keyword), guess) do
          IO.puts "You guessed it right, mizeráavi!"
          game2(remaining_chances, keyword, MapSet.put(right_guesses, guess))
        else
          IO.puts "Oops, best luck next time!"
          game2((remaining_chances - 1), keyword, right_guesses)
        end
    end
  end

  def game do
    game2(3, "Elixir", MapSet.new)
  end
end
