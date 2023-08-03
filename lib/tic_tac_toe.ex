defmodule TicTacToe do
  alias TicTacToe.Core.Game

  def start(), do: spawn(fn -> TicTacToe.Server.run(Game.new_game()) end)

  def play(pid, row, col) do
    send(pid, {:play, row, col})
    state(pid)
  end

  def state(pid) do
    send(pid, {:state, self()})

    receive do
      {:state, game} -> game
    end
  end
end
