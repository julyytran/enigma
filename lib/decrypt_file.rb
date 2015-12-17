require_relative 'enigma.rb'

e = Enigma.new(key, date)
e.key = ARGV[2]
e.date = ARGV[3].to_i
File.write(ARGV[1], e.decrypt(File.read(ARGV[0]).strip, ARGV[2]))
puts "Created #{ARGV[1]} with the key #{e.key} and date #{e.date}"
