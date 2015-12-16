class Cryptographer

attr_reader :sliced_indices, :rotated_indices

  def cipher
    ('a'..'z').to_a + ('0'..'9').to_a + [' ', '.', ',']
  end

  def create_rotation
    key_rotation
    date_offset
    total_rotation
  end

  def index_message(message)
    chars = message.split("")
    @indices = chars.map do |char|
      cipher.index(char)
    end
  end

  def slice_indices
    @sliced_indices = []
    @indices.each_slice(4) do |batch|
      @sliced_indices.push(batch)
    end
  end

  def rotate_forward
    @rotated_indices = []
    @sliced_indices.each do |slice|
      if slice.count == 4
        @rotated_indices << slice[0] + @a_rotation
        @rotated_indices << slice[1] + @b_rotation
        @rotated_indices << slice[2] + @c_rotation
        @rotated_indices << slice[3] + @d_rotation
      elsif slice.count == 3
        @rotated_indices << slice[0] + @a_rotation
        @rotated_indices << slice[1] + @b_rotation
        @rotated_indices << slice[2] + @c_rotation
      elsif slice.count == 2
        @rotated_indices << slice[0] + @a_rotation
        @rotated_indices << slice[1] + @b_rotation
      elsif slice.count == 1
        @rotated_indices << slice[0] + @a_rotation
      else slice.count == 0
      end
    end
  end

  def rotate_backward
    @rotated_indices = []
    @sliced_indices.each do |slice|
      if slice.count == 4
        @rotated_indices << slice[0] - @a_rotation
        @rotated_indices << slice[1] - @b_rotation
        @rotated_indices << slice[2] - @c_rotation
        @rotated_indices << slice[3] - @d_rotation
      elsif slice.count == 3
        @rotated_indices << slice[0] - @a_rotation
        @rotated_indices << slice[1] - @b_rotation
        @rotated_indices << slice[2] - @c_rotation
      elsif slice.count == 2
        @rotated_indices << slice[0] - @a_rotation
        @rotated_indices << slice[1] - @b_rotation
      elsif slice.count == 1
        @rotated_indices << slice[0] - @a_rotation
      else slice.count == 0
      end
    end
  end

  def encrypt(message, key = @key, date = @date)
    @key = "%05d" % key.to_s
    create_rotation
    index_message(message)
    slice_indices
    rotate_forward

    encrypted_message = @rotated_indices.map do |index|
      cipher[index % 39]
    end

    encrypted_message.join
  end

  def decrypt(message, key, date = @date)
    @key = "%05d" % key.to_s
    create_rotation
    index_message(message)
    slice_indices
    rotate_backward

    decrypted_message = @rotated_indices.map do |index|
      cipher[index % 39]
    end

    decrypted_message.join
  end

  def indices_of_cracked_message(index, rotator_index = 3)
    if index > 0
      @cracked_indices[index] = @rotator[rotator_index] + @indices[index]
      # puts @cracked_indices
      if rotator_index == 0
        indices_of_cracked_message(index - 1)
      else
        indices_of_cracked_message(index - 1, rotator_index - 1)
      end
    elsif index == 0
      @cracked_indices[0] = @rotator[rotator_index] + @indices[index]
      @cracked_indices
    end
  end

  def crack(encrypted, date = @date)

  end_indices = [37, 37, 4, 13, 3, 37, 37]
  index_message(encrypted)
  indices_matching_end = @indices[-7..-1]
  differences = indices_matching_end.zip(end_indices).map { |x, y| y - x}
  total_rotation = []
  differences.each do |difference|
    if difference < 0
      difference = difference % 39
    end
    total_rotation << difference
  end

  @cracked_indices = []
  @rotator = total_rotation[-4..-1]
  indices_of_cracked_message(((@indices.length) -1))

  original_message = @cracked_indices.map do |index|
    cipher[index % 39]
    end
  original_message.join
  end




end
