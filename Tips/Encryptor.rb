class Encrypt

def initialize(key, date)
  @key = key
  @date = date
end

def key_rotation
@akeyrot = @key[0..1].to_i  # => 42
end

def date_offset
date_offset = @date ** 2
@date_key = date_offset.to_s.split(""[-4..-1].join)
end
end

best_day_ever = (Time.now.strftime(%d%m%y%s).to_i)
e = Encrypt.new(best_day_ever.to_i)



# e = Encrypt.new(Random.rand(0..999999).to_s)  # => #<Encrypt:0x007f89fb02a418 @key="42775">
# # e = Encrypt.new("12345")
# e.key_rotation                                # => 42
# e                                             # => #<Encrypt:0x007f89fb02a418 @key="42775", @akeyrot=42>

#pass in date and key in main
