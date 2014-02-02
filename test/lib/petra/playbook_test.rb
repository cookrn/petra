require 'test_helper'

class Petra::PlaybookTest < Minitest::Test
  def test_accepts_a_name_on_initialize
    assert_raises ArgumentError do
      Petra::Playbook.new
    end

    playbook = Petra::Playbook.new :name

    assert_equal \
      :name,
      playbook.name
  end

  def test_is_runnable
    playbook = Petra::Playbook.new :name

    assert_respond_to \
      playbook,
      :run
  end
end
