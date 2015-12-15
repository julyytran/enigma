require_relative 'enigma.rb'

e = Enigma.new
e.key = ARGV[2]
e.date = ARGV[3].to_i
message = File.read(ARGV[0])
File.write(ARGV[1], e.decrypt(message.strip, ARGV[2]))
puts "Created #{ARGV[1]} with the key #{e.key} and date #{e.date}"
