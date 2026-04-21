defmodule Matematicas do
  def es_perfecto?(n) when n < 2, do: false
  def es_perfecto?(n), do: sumar_divisores(n, 1, 0) == n




  defp sumar_divisores(n, divisor, acc) when divisor > div(n, 2) do
    acc
  end

  defp sumar_divisores(n, divisor, acc) when rem(n, divisor) == 0 do
    sumar_divisores(n, divisor + 1, acc + divisor)
  end

  defp sumar_divisores(n, divisor, acc) do
    sumar_divisores(n, divisor + 1, acc)
  end
end

numero = String.to_integer(Enum.at(System.argv(), 0, "6"))

if Matematicas.es_perfecto?(numero) do
  IO.puts " #{numero} es un número perfecto."
else
  IO.puts " #{numero} NO es un número perfecto."
end
