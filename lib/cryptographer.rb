class Cryptographer

attr_reader :sliced_indices, :rotated_indices

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
      slice.count.times do |index|
        @rotated_indices << slice[index] + @total_rotation[index]
      end
    end
  end

  def rotate_backward
    @rotated_indices = []
    @sliced_indices.each do |slice|
      slice.count.times do |index|
        @rotated_indices << slice[index] - @total_rotation[index]
      end
    end
  end

  def rotation_prep(message)
    create_total_rotation
    index_message(message)
    slice_indices
  end

  def encrypt(message, key = @key, date = @date)
    @key = "%05d" % key.to_s
    rotation_prep(message)
    rotate_forward

    encrypted_message = @rotated_indices.map do |index|
      cipher[index % upper_bound]
    end

    encrypted_message.join
  end

  def decrypt(message, key, date = @date)
    @key = "%05d" % key.to_s
    rotation_prep(message)
    rotate_backward

    decrypted_message = @rotated_indices.map do |index|
      cipher[index % upper_bound]
    end

    decrypted_message.join
  end

  def crack_index_differences(encrypted)
    end_indices = [37, 37, 4, 13, 3, 37, 37]
    index_message(encrypted)
    indices_matching_end = @indices[-7..-1]
    @differences = indices_matching_end.zip(end_indices).map { |x, y| y - x}
  end

  def crack_total_rotation
    @total_rotation = []
    @differences.each do |difference|
      if difference < 0
        difference = difference % upper_bound
      end
      @total_rotation << difference
    end
  end

  def indices_of_cracked_message(index, rotator_index = 3)
    if index > 0
      @cracked_indices[index] = @rotator[rotator_index] + @indices[index]
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

  def get_cracked_indices
    @cracked_indices = []
    @rotator = @total_rotation[-4..-1]
    indices_of_cracked_message(((@indices.length) -1))
  end

  def crack(encrypted, date = @date)
    crack_index_differences(encrypted)
    crack_total_rotation
    get_cracked_indices

    original_message = @cracked_indices.map do |index|
      cipher[index % upper_bound]
      end
    original_message.join
    end

end
