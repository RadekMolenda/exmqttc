defmodule ExmqttcRegexTest do
  use ExUnit.Case, async: false

  test "parsing a simple topic to regex" do
    topic = "test/123"
    {:ok, regex} = Exmqttc.TopicParser.compile(topic)
    assert Regex.match?(regex, topic)
  end

  test "parsing a + placeholder topic to regex" do
    topic = "test/+"
    {:ok, regex} = Exmqttc.TopicParser.compile(topic)
    assert Regex.match?(regex, "test/123")
    refute Regex.match?(regex, "test/123/321")
  end

  test "parsing a # placeholder topic to regex" do
    topic = "test/#"
    {:ok, regex} = Exmqttc.TopicParser.compile(topic)
    assert Regex.match?(regex, "test/123")
    assert Regex.match?(regex, "test/123/321")
  end
end
