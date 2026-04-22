defmodule Docente do
  defstruct periodo: "", facultad: "", programa: "", genero: "",
            formacion: "", vinculacion: "", dedicacion: "", cargo: "", categoria: ""

  def crear(periodo, facultad, programa, genero, formacion, vinculacion, dedicacion, cargo, categoria) do
    %Docente{
      periodo: periodo,
      facultad: facultad,
      programa: programa,
      genero: genero,
      formacion: formacion,
      vinculacion: vinculacion,
      dedicacion: dedicacion,
      cargo: cargo,
      categoria: categoria
    }
  end

  def leer_csv(nombre) do
    if File.exists?(nombre) do
      nombre
      |> File.stream!()
      |> Stream.drop(1)
      |> Enum.map(&convertir_cadena_docente/1)
    else
      []
    end
  end

  defp convertir_cadena_docente(cadena) do
    [periodo, facultad, programa, genero, formacion, vinculacion, dedicacion, cargo, categoria] =
      cadena
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.trim(&1, "\""))

    Docente.crear(periodo, facultad, programa, genero, formacion, vinculacion, dedicacion, cargo, categoria)
  end

  def generar_mensaje(docente) do
    """
    ─────────────────────────────────────
    Periodo:     #{docente.periodo}
    Facultad:    #{docente.facultad}
    Programa:    #{docente.programa}
    Género:      #{docente.genero}
    Formación:   #{docente.formacion}
    Vinculación: #{docente.vinculacion}
    Dedicación:  #{docente.dedicacion}
    Cargo:       #{docente.cargo}
    Categoría:   #{docente.categoria}
    """
  end

  def generar_mensaje_docentes(lista, parser) do
    lista
    |> Enum.map(parser)
    |> Enum.join()
  end
end
