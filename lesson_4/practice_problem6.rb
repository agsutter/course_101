# Amend this array so that the names are all shortened to just the first
# three characters:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

def amend_to_three_chars(array)
  array.map { |item| item[0..2] }
end

p amend_to_three_chars(flintstones)
