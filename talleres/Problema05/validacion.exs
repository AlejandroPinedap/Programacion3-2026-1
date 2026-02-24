defmodule Validacion do
  def main do
    validacion_nombre =
      "ingrese el nombre de usuario"
      |> Util.ingresar(:texto)

    validacion_edad =
      "ingrese su edad"
      |> Util.ingresar(:entero)

    validacion_credenciales =
      "ingrese credenciales "
      |> Util.ingresar(:texto)

    validacion_intentos =
      "ingrese numero intentos fallidos"
      |> Util.ingresar(:entero)

    validacion =
      validardatos(
        validacion_nombre,
        validacion_edad,
        validacion_credenciales,
        validacion_intentos
      )

    mostrar_resultado(validacion)
  end

  defp validardatos(
         validacion_nombre,
         validacion_edad,
         validacion,
         credenciales,
         validacion_intentos
       ) do
    unless validacion_credenciales do
      {:error, "acceso denegado #{validacion_nombre}"}
    else
      if edad < 18 do
        {:error, " su edad debe ser mayor a 18"}
      end
    end
  end

  |>Util.mostrar_mensaje()

  def mostrar_resultado(resultado) do
    {:ok, mensaje} = resultado
      IO.puts (mensaje)
  end

  def mostrar_resultado({:error, mensaje} ) do
      IO.puts (mensaje)
  end
end

Validacion.main()
