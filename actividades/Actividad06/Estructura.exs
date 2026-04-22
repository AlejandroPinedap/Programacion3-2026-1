defmodule Estructura do
  def main do
    "Docentes.csv"
    |> Docente.leer_csv()
    |> filtrar_datos_interes()
    |> Docente.generar_mensaje_docentes(&Docente.generar_mensaje/1)
    |> Util.mostrar_mensaje()
  end

  defp filtrar_datos_interes(docentes) do
    docentes
    |> Enum.filter(fn d ->
      d.formacion == "MAESTRIA" and d.vinculacion == "PLANTA"
    end)
  end
end

Estructura.main()
