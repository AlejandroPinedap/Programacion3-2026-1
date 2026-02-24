defmodule Validacion do
  def main do
    validacion_nombre =
      "ingrese el nombre de usuario"
      |> Util.ingresar(:texto)

    validacion_edad =
      "ingrese su edad"
      |> Util.ingresar(:entero)

    validacion_credenciales =
      "tiene credenciales si/no"
      |> Util.ingresar(:texto)

    

    defp validardatos(validacion_nombre,validacion_edad,validacion,credenciales) do

      if validacion_nombre == validacion_nombre  do

        if validacion_edad >= 18 do

          if validacion_credenciales == "si" do
            {:ok, "Acceso concedido"}

          else
            {:error,"datos invalidos"}
          end
        end
      end
    end
  end
end

Validacion.main()
