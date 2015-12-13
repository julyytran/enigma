require_relative 'cryptographer'

class Enigma < Cryptographer

  attr_reader :key,
              :a_key_rotation, :b_key_rotation, :c_key_rotation, :d_key_rotation,
              :a_date_offset, :b_date_offset, :c_date_offset, :d_date_offset,
              :a_rotation, :b_rotation, :c_rotation, :d_rotation

  attr_accessor :date

  def initialize(key = Random.rand(0..99999).to_s, date = Time.now.strftime("%d%m%y").to_i)
    @key = "%05d" % key
    @date = date
  end

  def key_rotation
    @a_key_rotation = @key[0..1].to_i
    @b_key_rotation = @key[1..2].to_i
    @c_key_rotation = @key[2..3].to_i
    @d_key_rotation = @key[3..4].to_i
  end

  def date_offset
    date_squared = @date ** 2
    last_four_digits = date_squared.to_s[-4..-1]
    @a_date_offset = last_four_digits[-4].to_i
    @b_date_offset = last_four_digits[-3].to_i
    @c_date_offset = last_four_digits[-2].to_i
    @d_date_offset = last_four_digits[-1].to_i
  end

  def total_rotation
    @a_rotation = @a_key_rotation + @a_date_offset
    @b_rotation = @b_key_rotation + @b_date_offset
    @c_rotation = @c_key_rotation + @c_date_offset
    @d_rotation = @d_key_rotation + @d_date_offset
  end

end
