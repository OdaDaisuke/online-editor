defmodule ServerWeb.SourceController do
  use ServerWeb, :controller
  import CodeService

  alias Server.Sources
  alias Server.Sources.Source

  action_fallback ServerWeb.FallbackController

  def exec(conn, %{"source" => source, "language" => lang}) do
    exec_result = CodeService.exec(lang, source)
    send_resp(conn, 200, exec_result)
  end

  def index(conn, _params) do
    sources = Sources.list_sources()
    render(conn, "index.json", sources: sources)
  end

  def create(conn, %{"source" => source_params}) do
    with {:ok, %Source{} = source} <- Sources.create_source(source_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.source_path(conn, :show, source))
      |> render("show.json", source: source)
    end
  end

  def show(conn, %{"id" => id}) do
    source = Sources.get_source!(id)
    render(conn, "show.json", source: source)
  end

  def update(conn, %{"id" => id, "source" => source_params}) do
    source = Sources.get_source!(id)

    with {:ok, %Source{} = source} <- Sources.update_source(source, source_params) do
      render(conn, "show.json", source: source)
    end
  end

  def delete(conn, %{"id" => id}) do
    source = Sources.get_source!(id)

    with {:ok, %Source{}} <- Sources.delete_source(source) do
      send_resp(conn, :no_content, "")
    end
  end
end
