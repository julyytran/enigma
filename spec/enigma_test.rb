# require 'simplecov'
# SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/enigma'

class EnigmaTest < Minitest::Test

  def test_initialized_with_random_key
    e = Enigma.new(12345)
    assert_equal '12345', e.key
  end

  def test_initialized_with_todays_date
    e = Enigma.new
    today = Time.now.strftime("%d%m%y").to_i
    assert_equal today, e.date
  end

  def test_create_key_rotation
    e = Enigma.new(12345)
    e.create_key_rotation
    assert_equal [12, 23, 34, 45], e.key_rotation
  end

  def test_create_date_offset
    e = Enigma.new(12345, 161215)
    e.create_date_offset
    assert_equal [6, 2, 2, 5], e.date_offset
  end

  def test_create_total_rotation
    e = Enigma.new(12345, 161215)
    e.create_total_rotation
    assert_equal [18, 25, 36, 50], e.total_rotation
  end

  def test_cipher_creation
    e = Enigma.new(12345, 121215)
    assert_equal ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
      "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0",
      "1", "2", "3", "4", "5", "6", "7", "8", "9", " ", ".", ",", "A", "B", "C",
      "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R",
      "S", "T", "U", "V", "W", "X", "Y", "Z", "!", "@", "#", "$", "%", "^", "&",
      "*", "(", ")", "[", "]", "<", ">", ";", ":", "/", "?", "''", "|"], e.cipher
  end

  def test_upper_bound_of_cipher
    e = Enigma.new(12345, 121215)
    assert_equal 85, e.cipher.length
  end

end
