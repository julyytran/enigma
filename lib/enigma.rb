require_relative 'cryptographer'

class Enigma < Cryptographer

  attr_reader :key_rotation, :date_offset, :total_rotation
  attr_accessor :date, :key

  def initialize(key = Random.rand(0..99999).to_s, date = Time.now.strftime("%d%m%y").to_i)
    @key = "%05d" % key
    @date = date
  end

  def create_key_rotation
    @key_rotation = [@key[0..1].to_i, @key[1..2].to_i, @key[2..3].to_i, @key[3..4].to_i]
  end

  def create_date_offset
    date_squared = @date ** 2
    last_four_digits = date_squared.to_s[-4..-1]
    @date_offset = [last_four_digits[-4].to_i, last_four_digits[-3].to_i, last_four_digits[-2].to_i, last_four_digits[-1].to_i]
  end

  def create_total_rotation
    create_key_rotation
    create_date_offset
    @total_rotation = @key_rotation.zip(@date_offset).map { |x, y| x + y}
  end

  def cipher
    ('a'..'z').to_a + ('0'..'9').to_a +
    [' ', '.', ','] + ('A'..'Z').to_a +
    ['!', '@', '#', '$', '%', '^', '&', '*', '(',
    ')', '[', ']', '<', '>', ';', ':', '/', '?', '|']

  end

  def upper_bound
    cipher.length
  end

end
