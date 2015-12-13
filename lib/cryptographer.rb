class Cryptographer

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

  def crack(message, date = @date)
    rotated_indices = [37, 37, 4, 13, 3, 37, 37]
    
    #determine what key is
      #calculate offsets from message date and index values of ..end..
    decrypt(message, @cracked_key)
  end

end
