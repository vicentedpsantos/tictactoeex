defmodule TicTacToe.Server do
  alias TicTacToe.Core.{Game, WinValidator}

  def run(game) do
    updated_game = listen(game)
    run(updated_game)
  end

  def listen(game) do
    receive do
      {:play, row, col} ->
        game
        |> Game.set_position(row, col)
        |> WinValidator.validate()

      {:state, from} ->
        send(from, {:state, game})
        game
    end
  end
end
