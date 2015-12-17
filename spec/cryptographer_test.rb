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
    e = Enigma.new("12345", 121215)
    assert_equal "1GI)", e.encrypt("july")
  end

  def test_encrypt_for_less_than_four_letters
    e = Enigma.new("12345", 121215)
    assert_equal "1GI", e.encrypt("jul")
  end

  def test_encrypt_for_more_than_four_letters
    e = Enigma.new("12345", 121215)
    assert_equal "1GI)Q", e.encrypt("july.")
  end

  def test_encrypt_capitals
    e = Enigma.new("12345")
    assert_equal "ZZ?fP[fqP>dl", e.encrypt("HAHA LOL OMG")
  end

  def test_encrypt_symbols
    e = Enigma.new("12345")
    assert_equal "qgs7ckw.go0Ck", e.encrypt("?!@#$%^&*()[]")
  end

  def test_decrypt_for_exactly_four_letters
    e = Enigma.new("12345", 121215)
    assert_equal "july", e.decrypt("1GI)", 12345)
  end

  def test_decrypt_for_less_than_four_letters
    e = Enigma.new("12345", 121215)
    assert_equal "jul", e.decrypt("1GI", 12345)
  end

  def test_decrypt_for_more_than_four_letters
    e = Enigma.new("12345", 121215)
    assert_equal "july.", e.decrypt("1GI)Q", 12345)
  end

  def test_decrypt_capitals
    e = Enigma.new("12345")
    assert_equal "HAHA LOL OMG", e.decrypt("ZZ?fP[fqP>dl", 12345)
  end

  def test_decrypt_symbols
    e = Enigma.new("12345")
    assert_equal "?!@#$%^&*()[]", e.decrypt("qgs7ckw.go0Ck", 12345)
  end

  def test_crack_message_end
    e = Enigma.new("12345")
    assert_equal "..end..", e.crack("QXBYvX(")
  end

  def test_crack_entire_message
    e = Enigma.new("12345")
    assert_equal "hi ..end..", e.crack("z7*dQ3KOQX")
  end

  def test_crack_capitals
    e = Enigma.new("12345")
    assert_equal "HAHA LOL OMG ..end..", e.crack("ZZ?fP[fqP>dlPX(P52(d")
  end

  def test_crack_symbols
    e = Enigma.new("12345")
    assert_equal "?!@#$%^&*()[] ..end..", e.crack("qgs7ckw.go0CkW(dw,AdQ")
  end

end
