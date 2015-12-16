require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/cryptographer'
require_relative '../lib/enigma'

class CryptographerTest < Minitest::Test

  def test_cipher_creation
    e = Enigma.new("14859", 121215)
    assert_equal ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
      "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
      "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", " ", ".", ","], e.cipher
  end

  def test_index_message
    e = Enigma.new("14859", 121215)
    assert_equal [7, 8], e.index_message("hi")
  end

  def test_slice_indices
    e = Enigma.new("14859", 121215)
    e.index_message("hello")
    e.slice_indices
    assert_equal [[7, 4, 11, 11], [14]], e.sliced_indices
  end

  def test_rotate_forward
    e = Enigma.new("14859", 121215)
    e.key_rotation
    e.date_offset
    e.total_rotation
    e.index_message("hello")
    e.slice_indices
    e.rotate_forward
    assert_equal [27, 54, 98, 75, 34], e.rotated_indices
  end

  def test_rotate_backward
    e = Enigma.new("14859", 121215)
    e.key_rotation
    e.date_offset
    e.total_rotation
    e.index_message("hello")
    e.slice_indices
    e.rotate_backward
    assert_equal [-13, -46, -76, -53, -6], e.rotated_indices
  end

  def test_encrypt_for_exactly_four_letters
    e = Enigma.new("14859", 121215)
    assert_equal "35uk", e.encrypt("july")
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

  def test_crack_message_end
    e = Enigma.new("12345")
    assert_equal "..end..", e.crack("qxbyvx8")
  end

  def test_crack_entire_message
    e = Enigma.new("12345")
    assert_equal "hi ..end..", e.crack("z77jq3koqx")
  end

end
