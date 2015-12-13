require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/cryptographer'
require_relative '../lib/enigma'

class CryptographerTest < Minitest::Test

  def test_encrypt_for_exactly_four_letters
    e = Enigma.new("14859", 121215)
    assert_equal "35uk", e.encrypt("july")
  end

  def test_cipher_creation

  end

  def test_index_message

  end

  def test_slice_indices

  end

  def test_rotate_forward

  end

  def test_rotate_backward

  end

  def test_encrypt_for_less_than_four_letters
    e = Enigma.new("14859", 121215)
    assert_equal "35u", e.encrypt("jul")
  end

  def test_encrypt_for_more_than_four_letters
    e = Enigma.new("14859", 121215)
    assert_equal "35uks", e.encrypt("july.")
  end

  def test_decrypt_for_exactly_four_letters
    e = Enigma.new("14859", 121215)
    assert_equal "july", e.decrypt("35uk", 14859)
  end

  def test_decrypt_for_less_than_four_letters
    e = Enigma.new("14859", 121215)
    assert_equal "jul", e.decrypt("35u", 14859)
  end

  def test_decrypt_for_more_than_four_letters
    e = Enigma.new("14859", 121215)
    assert_equal "july.", e.decrypt("35uks", 14859)
  end

  def test_crack
    e = Enigma.new
    e.date = 121215
    assert_equal 31108, e.key
  end

end
