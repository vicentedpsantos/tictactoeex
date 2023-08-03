defmodule TicTacToe.Core.WinValidator do
  alias TicTacToe.Core.Game

  @winning_combinations [
    [{0, 0}, {0, 1}, {0, 2}],
    [{1, 0}, {1, 1}, {1, 2}],
    [{2, 0}, {2, 1}, {2, 2}],
    [{0, 0}, {1, 0}, {2, 0}],
    [{0, 1}, {1, 1}, {2, 1}],
    [{0, 2}, {1, 2}, {2, 2}],
    [{0, 0}, {1, 1}, {2, 2}],
    [{2, 0}, {1, 1}, {0, 2}]
  ]

  def validate(%Game{} = game) do
    Enum.reduce(@winning_combinations, game, fn combination, game ->
      find_winner(combination, game)
    end)
  end

  defp find_winner([c1, c2, c3], %Game{board: board} = game) do
    validate_winner(board[c1], board[c2], board[c3])
    |> case do
      {:winner, winner} -> %{game | winner: winner}
      :none -> game
    end
  end

  def validate_winner(c1, c2, c3) when c1 == c2 and c2 == c3 and c1 != " ", do: {:winner, c1}
  def validate_winner(_, _, _), do: :none
end
