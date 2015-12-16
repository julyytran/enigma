require_relative 'enigma.rb'

e = Enigma.new
File.write(ARGV[1], e.encrypt(File.read(ARGV[0]).strip))
puts "Created #{ARGV[1]} with the key #{e.key} and date #{e.date}"
