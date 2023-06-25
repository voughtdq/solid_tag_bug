defmodule SolidTagBug.FS do
  @behaviour Solid.FileSystem

  @impl true
  def read_template_file("layout", _) do
    """
    {% render "world", name: name %}
    """
  end

  def read_template_file("world", _) do
    """
    {% world %}
    I'm {{ name }}
    """
  end

  def read_template_file("layout_world_world", _) do
    """
    {% render "world_world", name: name %}
    """
  end

  def read_template_file("world_world", _) do
    """
    {% world %}! {{ name }} was here.
    {% render "world", name: "Tim" %}
    """
  end

  def read_template_file(_, _) do
    raise "This is only a test."
  end
end

defmodule SolidTagBug.WorldTag do
  import NimbleParsec
  alias Solid.Parser.BaseTag
  @behaviour Solid.Tag

  @impl true
  def spec(_parser) do
    ignore(BaseTag.opening_tag())
    |> ignore(string("world"))
    |> ignore(BaseTag.closing_tag())
  end

  @impl true
  def render(_world, _context, _options) do
    [text: "Hello World"]
  end
end

defmodule SolidTagBug do
  alias SolidTagBug.FS

  def render_world(attrs \\ %{}) do
    template = FS.read_template_file("world", [])
    parsed = Solid.parse!(template, parser: SolidTagBug.Parser)
    Solid.render!(parsed, attrs, file_system: {SolidTagBug.FS, []})
  end

  def render_layout(attrs \\ %{}) do
    template = FS.read_template_file("layout", [])
    parsed = Solid.parse!(template, parser: SolidTagBug.Parser)
    Solid.render!(parsed, attrs, file_system: {SolidTagBug.FS, []}, parser: SolidTagBug.Parser)
  end

  def render_world_world(attrs \\ %{}) do
    template = FS.read_template_file("layout_world_world", [])
    parsed = Solid.parse!(template, parser: SolidTagBug.Parser)
    Solid.render!(parsed, attrs, file_system: {SolidTagBug.FS, []}, parser: SolidTagBug.Parser)
  end

end
