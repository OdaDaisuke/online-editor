defmodule ServerWeb.SourceView do
  use ServerWeb, :view
  alias ServerWeb.SourceView

  def render("index.json", %{sources: sources}) do
    %{data: render_many(sources, SourceView, "source.json")}
  end

  def render("show.json", %{source: source}) do
    %{data: render_one(source, SourceView, "source.json")}
  end

  def render("source.json", %{source: source}) do
    %{id: source.id,
      file_name: source.file_name,
      body: source.body}
  end
end
