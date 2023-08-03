defmodule TicTacToe.Core.Game do
  defstruct ~w(board error turn winner)a

  @initial_board %{
    {0, 0} => " ",
    {0, 1} => " ",
    {0, 2} => " ",
    {1, 0} => " ",
    {1, 1} => " ",
    {1, 2} => " ",
    {2, 0} => " ",
    {2, 1} => " ",
    {2, 2} => " "
  }

  def new_game do
    %__MODULE__{
      board: @initial_board,
      turn: "X",
      error: nil
    }
  end

  def set_position(%__MODULE__{board: board, turn: turn} = game, row, col) do
    with :ok <- check_within_boundaries(row, col),
         :ok <- check_position(board, row, col) do
      updated_board = Map.put(board, {row, col}, turn)

      %__MODULE__{board: updated_board, turn: change_turn(turn), error: nil}
    else
      {:error, reason} ->
        %{game | error: "Couldn't perform play: #{reason}"}
    end
  end

  defp check_position(board, row, col) do
    board
    |> get_position(row, col)
    |> Kernel.==(" ")
    |> case do
      false -> {:error, :square_taken}
      true -> :ok
    end
  end

  def get_position(board, row, col), do: board[{row, col}]

  defp check_within_boundaries(row, col) do
    if row <= 2 and col <= 2, do: :ok, else: {:error, :outside_boundaries}
  end

  defp change_turn("X"), do: "O"
  defp change_turn("O"), do: "X"
end
