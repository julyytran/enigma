# require 'simplecov'
# SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/cryptographer'
require_relative '../lib/enigma'

class CryptographerTest < Minitest::Test

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
#
  def test_rotate_forward
    e = Enigma.new("14859", 121215)
    e.create_total_rotation
    e.index_message("hello")
    e.slice_indices
    e.rotate_forward
    assert_equal [27, 54, 98, 75, 34], e.rotated_indices
  end

  def test_rotate_backward
    e = Enigma.new("14859", 121215)
    e.create_total_rotation
    e.index_message("hello")
    e.slice_indices
    e.rotate_backward
    assert_equal [-13, -46, -76, -53, -6], e.rotated_indices
  end

  def test_encrypt_for_exactly_four_letters
    e = Enigma.new("14859", 121215)
    assert_equal "3^nd", e.encrypt("july")
  end

  def test_encrypt_for_less_than_four_letters
    e = Enigma.new("14859", 121215)
    assert_equal "3^n", e.encrypt("jul")
  end

  def test_encrypt_for_more_than_four_letters
    e = Enigma.new("14859", 121215)
    assert_equal "3^ndS", e.encrypt("july.")
  end

  def test_encrypt_capitals_and_symbols
    e = Enigma.new("12345")
    assert_equal "adep&fq", e.encrypt("#YOLO!!")
  end

  def test_decrypt_for_exactly_four_letters
    e = Enigma.new("14859", 121215)
    assert_equal "july", e.decrypt("3^nd", 14859)
  end

  def test_decrypt_for_less_than_four_letters
    e = Enigma.new("14859", 121215)
    assert_equal "jul", e.decrypt("3^n", 14859)
  end

  def test_decrypt_for_more_than_four_letters
    e = Enigma.new("14859", 121215)
    assert_equal "july.", e.decrypt("3^ndS", 14859)
  end

  def test_decrypt_capitals_and_symbols
    e = Enigma.new("12345")
    assert_equal "#YOLO!!", e.decrypt("adep&fq", 12345)
  end

  def test_crack_message_end
    e = Enigma.new("12345")
    assert_equal "..end..", e.crack("QXBYvX(")
  end

  def test_crack_entire_message
    e = Enigma.new("12345")
    assert_equal "hi ..end..", e.crack("z7*cQ3KOQX")
  end

  def test_crack_capitals_and_symbols
    e = Enigma.new("12345")
    assert_equal "#YOLO!!..end..", e.crack("adep&fqcQ3KOQX")
  end

end
