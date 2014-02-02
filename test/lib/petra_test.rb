require 'test_helper'

class PetraTest < Minitest::Test
  def test_knows_its_gem_root
    assert_equal \
      gem_root,
      Petra::ROOTPATH
  end

  def test_knows_its_lib_root
    assert_equal \
      lib_root,
      Petra::LIBPATH
  end

  def test_has_a_playbook_factory
    assert_respond_to \
      Petra,
      :playbook
  end

  private

  def gem_root
    @_gem_root ||=
      File.expand_path \
        File.join(
          __FILE__,
          '../../../'
        )
  end

  def lib_root
    @_lib_root ||=
      File.expand_path \
        File.join(
          gem_root,
          'lib'
        )
  end
end
