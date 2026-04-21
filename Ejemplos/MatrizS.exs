defmodule Matriz do
  def simetrica?(matriz) do
    n = length(matriz)

    Enum.all?(0..(n - 1), fn i ->
      Enum.all?(0..(n - 1), fn j ->
        Enum.at(Enum.at(matriz, i), j) == Enum.at(Enum.at(matriz, j), i)
      end)
    end)
  end
end

# --- Prueba ---
simetrica = [
  [1, 2, 3],
  [2, 5, 6],
  [3, 6, 9]
]

no_simetrica = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
]

IO.puts("¿Es simétrica? #{Matriz.simetrica?(simetrica)}")
IO.puts("¿Es simétrica? #{Matriz.simetrica?(no_simetrica)}")
