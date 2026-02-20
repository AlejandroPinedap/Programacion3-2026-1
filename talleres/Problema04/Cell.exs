defmodule Cell do
  @moduledoc """
  Módulo que calcula el valor del descuento y el valor final
  """

  @doc """
  Función principal
  Calcula el valor del descuento y el valor final,
  luego muestra el resultado.
  """
  def main do
    valor_producto =
      "Ingrese el valor del producto: "
      |> Util.ingresar(:entero)

    porcentaje_descuento =
      "Ingrese el porcentaje de descuento: "
      |> Util.ingresar(:real)

    valor_descuento =
      calcular_valor_descuento(valor_producto, porcentaje_descuento)

    valor_final =
      calcular_valor_final(valor_producto, valor_descuento)

    generar_mensaje(valor_descuento, valor_final)
    |> Util.mostrar_mensaje()
  end

  @doc "multiplicamos  v.producto por el porcentaje del descuento"
  defp calcular_valor_descuento(valor_producto, porcentaje_descuento) do
    valor_producto * porcentaje_descuento
  end

  @doc ""
  defp calcular_valor_final(valor_producto, valor_descuento) do
    valor_producto - valor_descuento
  end

  @doc "false"
  defp generar_mensaje(valor_descuento, valor_final) do
    valor_descuento = Float.round(valor_descuento, 1)
    valor_final = Float.round(valor_final, 1)

    "Valor de descuento $#{valor_descuento} y el valor final $#{valor_final}"
  end
end

Cell.main()

# prueba del uso de io.lib.format

# defp generar_mensaje(valor_descuento, valor_final) do
# descuento = :io_lib.format("~.2f", [valor_descuento]) |> List.to_string()
# final = :io_lib.format("~.2f", [valor_final]) |> List.to_string()

# "Valor de descuento $#{descuento} y el valor final $#{final}"
# end
