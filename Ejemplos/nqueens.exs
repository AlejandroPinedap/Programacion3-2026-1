defmodule NQueens do
  @moduledoc """
  Solución al problema de las N Reinas usando backtracking.
  """

  # ¿Es seguro colocar una reina en esta columna?
  def safe?(queens, col) do
    Enum.with_index(queens)
    |> Enum.all?(fn {q_col, dist} ->
      q_col != col and
      abs(q_col - col) != dist + 1
    end)
  end

  # Punto de entrada: resuelve para un tablero N x N
  def solve(n), do: place(n, 0, [])

  # Caso base: ya colocamos N reinas → solución encontrada
  defp place(n, n, queens), do: [Enum.reverse(queens)]

  # Caso recursivo: probar cada columna en la fila actual
  defp place(n, row, queens) do
    0..(n - 1)
    |> Enum.filter(fn col -> safe?(queens, col) end)
    |> Enum.flat_map(fn col -> place(n, row + 1, [col | queens]) end)
  end

  # Imprime el tablero en consola
  def print_board(queens) do
    n = length(queens)
    IO.puts("\n+" <> String.duplicate("---+", n))
    Enum.each(queens, fn col ->
      row_str =
        0..(n - 1)
        |> Enum.map(fn c -> if c == col, do: " Q ", else: "   " end)
        |> Enum.join("|")
      IO.puts("| " <> row_str <> " |")
      IO.puts("+" <> String.duplicate("---+", n))
    end)
  end
end

# ========================
#  EJECUCIÓN
# ========================

IO.puts("=== Problema de las N Reinas ===\n")

# Mostrar número de soluciones para distintos tableros
Enum.each([4, 5, 6, 7, 8], fn n ->
  count = NQueens.solve(n) |> length()
  IO.puts("Tablero #{n}x#{n} → #{count} soluciones")
end)

# Mostrar la primera solución del tablero 4x4 visualmente
IO.puts("\n--- Primera solución para 4x4 ---")
solution = NQueens.solve(4) |> List.first()
IO.inspect(solution, label: "Columnas")
NQueens.print_board(solution)

# Mostrar la primera solución del tablero 8x8 visualmente
IO.puts("\n--- Primera solución para 8x8 ---")
solution8 = NQueens.solve(8) |> List.first()
IO.inspect(solution8, label: "Columnas")
NQueens.print_board(solution8)
