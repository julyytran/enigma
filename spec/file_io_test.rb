require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/cryptographer'
require_relative '../lib/enigma'

class FileIOTest < Minitest::Test

  def test_encrypt_file_reads_argv0
    # e = Enigma.new
    `ruby ./lib/encrypt.rb message.txt encrypted.txt` #weird Proc is returned
    # message = File.read(ARGV[0])
    assert_equal "july july", message
  end

  def test_encrypt_file_encrypts_contents

  end

  def test_encrypt_file_writes_argv1

  end

  def test_decrypt_file_reads_argv0

  end

  def test_decrypt_file_decrypts_contents

  end

  def test_decrypt_file_writes_argv1

  end

  def test_crack_file_reads_argv0

  end

  def test_crack_file_cracks_contents

  end

  def test_crack_file_writes_argv1

  end

end
