defmodule SaludoHora do
  @moduledoc """
  Módulo que obtiene la hora actual del sistema
  """

  def main do
    nombre =
      "Ingrese su nombre: "
      |> Util.ingresar(:texto)

    hora_actual = obtener_hora()

    hora_actual
    |> generar_saludo(nombre)
    |> Util.mostrar_mensaje()
  end



  defp obtener_hora do
    {{_, _, _}, {hora, _, _}} = :calendar.local_time()
    hora
  end

  defp generar_saludo(hora, nombre) do
    cond do
      hora >= 0 and hora <= 11 ->
        "Buenos días #{nombre}"

      hora >= 12 and hora <= 17 ->
        "Buenas tardes #{nombre}"

      hora >= 18 and hora <= 23 ->
        "Buenas noches #{nombre}"
    end
  end
end

SaludoHora.main()
