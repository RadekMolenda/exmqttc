defmodule Exmqttc.TopicParser do
  @moduledoc false

  def compile(topic) do
    regex = topic
    |> tokenize
    |> Enum.map(&replace/1)
    |> Enum.join("/")
    Regex.compile("^#{regex}$")
  end

  def tokenize(topic) do
    String.split(topic, "/")
  end

  def replace("+" <> _data) do
    "[a-zA-Z0-9_-]+"
  end

  def replace("#") do
    ".*"
  end

  def replace(input), do: input
end
