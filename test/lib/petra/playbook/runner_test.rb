require 'test_helper'

class Petra::Playbook::RunnerTest < Minitest::Test
  def test_has_an_execution_factory
    assert_respond_to \
      Petra::Playbook::Runner,
      :execute
  end

  def test_accepts_a_playbook_on_initialize
    assert_raises ArgumentError do
      Petra::Playbook::Runner.new
    end

    playbook = Petra::Playbook.new :name
    runner = Petra::Playbook::Runner.new playbook

    assert_equal \
      playbook,
      runner.playbook
  end

  def test_computes_playbook_name
    playbook = Petra::Playbook.new :name
    runner = Petra::Playbook::Runner.new playbook

    assert_equal \
      "#{ playbook.name }.yml",
      runner.playbook_name
  end

  def test_computes_command
    playbook = Petra::Playbook.new :name
    runner = Petra::Playbook::Runner.new playbook

    assert_match \
      /ansible-playbook/,
      runner.command
  end
end
