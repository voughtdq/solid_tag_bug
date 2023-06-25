defmodule SolidTagBugTest do
  use ExUnit.Case
  doctest SolidTagBug

  test "it renders the tag when rendered directly" do
    result = to_string(SolidTagBug.render_world(%{"name" => "Bob"}))
    assert result =~ "Hello World"
    assert result =~ "Bob"
  end

  test "it renders the tag when rendered using Solid.Tag.Render" do
    result = to_string(SolidTagBug.render_layout(%{"name" => "Bob"}))
    assert result =~ "Hello World"
    assert result =~ "Bob"
  end

  test "it renders the tag when rendered using Solid.Tag.Render when rendering deeper" do
    result = to_string(SolidTagBug.render_world_world(%{"name" => "Bob"}))
    assert result =~ "Hello World!"
    assert result =~ "Bob"
    assert result =~ "I'm Tim"
  end
end
