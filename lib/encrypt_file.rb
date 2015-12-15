require_relative 'enigma.rb'

e = Enigma.new
message = File.read(ARGV[0])
File.write(ARGV[1], e.encrypt(message.strip))
puts "Created #{ARGV[1]} with the key #{e.key} and date #{e.date}"
