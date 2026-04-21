defmodule Matriz do
  def suma_diagonal_secundaria(matriz) do
    n = length(matriz)

    Enum.reduce(0..(n - 1), 0, fn i, acumulador ->
      fila = Enum.at(matriz, i)
      elemento = Enum.at(fila, n - 1 - i)
      acumulador + elemento
    end)
  end
end

# --- Prueba ---
matriz = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
]

resultado = Matriz.suma_diagonal_secundaria(matriz)
IO.puts("Suma diagonal secundaria: #{resultado}")
