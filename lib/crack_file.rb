require_relative 'enigma.rb'

e = Enigma.new
e.date = ARGV[2].to_i
File.write(ARGV[1], e.crack(File.read(ARGV[0]).strip))
puts "Created #{ARGV[1]} with the key #{e.key} and date #{e.date}"
