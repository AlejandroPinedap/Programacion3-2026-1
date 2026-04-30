defmodule Matriznxm do

  def main do

    matriz = [
      [60, 22, 41, 5],
      [13, 33, 44, 5],
      [89, 10, 100, 99],
      [5, 101, 6, 34]
    ]

    

    t1 = Task.async(fn ->
    a = s1(matriz)
    IO.puts("t1 termino => a (suma debajo la diag) = #{a}")
    a
    end)

    t2 = Task.async(fn ->
      b = s2(matriz)
      IO.puts("t2 termino => b (promedio) = #{b}")
      b
    end)

    a = Task.await(t1)
    b= Task.await(t2)

    c= s3(a, b)

    s4(c)
  end

  def s1(matriz) do
    matriz
    |> Enum.with_index()
    |> Enum.reduce(0, fn {fila, i}, acc ->
      fila
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {valor, j}, acc2 ->
        if i> j, do: acc2 + valor, else: acc2
      end)
    end)
  end

  def s2(matriz) do
    {suma, count} =
      Enum.reduce(matriz, {0,0}, fn fila, {s,c} ->
        {s + Enum.sum(fila), c + length(fila)}
      end)
      suma / count
  end

  def s3(a,b), do: a*b

  def s4(c) do
    IO.puts(" Resultado")
    IO.puts("s3 = c= a * b = #{c}")
    IO.puts("s4 = c = #{c}")
  end
end

Matriznxm.main()
