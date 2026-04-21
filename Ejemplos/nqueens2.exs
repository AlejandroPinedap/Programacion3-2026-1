defmodule NQueens do
  def safe?(queens, col) do
    Enum.with_index(queens)
    |> Enum.all?(fn {q_col, dist} ->
      q_col != col and
      abs(q_col - col) != dist + 1
    end)
  end

  def solve(n), do: place(n, 0, [])

  defp place(n, n, queens), do: [Enum.reverse(queens)]

  defp place(n, row, queens) do
    0..(n - 1)
    |> Enum.filter(fn col -> safe?(queens, col) end)
    |> Enum.flat_map(fn col -> place(n, row + 1, [col | queens]) end)
  end
end

# ========================
#  EJECUCIÓN
# ========================

IO.write("¿De qué tamaño es el tablero? (N): ")

n =
  IO.read(:line)
  |> String.trim()
  |> Integer.parse()
  |> case do
    {num, _} when num > 0 -> num
    _ ->
      IO.puts("Número inválido, usando 8 por defecto.")
      8
  end

IO.puts("\nCalculando soluciones para tablero #{n}x#{n}...")

count = NQueens.solve(n) |> length()

IO.puts("→ El tablero #{n}x#{n} tiene #{count} soluciones.")
