require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/Enigma'

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

  def test_key_rotation_calculated
    e = Enigma.new
    e.key_rotation
    assert_equal e.key[0..1].to_i, e.a_key_rotation
  end

  def test_date_offset_calculated
    e = Enigma.new
    date_squared = e.date ** 2
    last_four_digits = date_squared.to_s[-4..-1]
    e.date_offset
    assert_equal last_four_digits[-4].to_i, e.a_date_offset
  end

  def test_total_rotation_calculated
    e = Enigma.new
    e.key_rotation
    e.date_offset
    e.total_rotation
    assert_equal (e.a_key_rotation + e.a_date_offset), e.a_rotation
  end

end
