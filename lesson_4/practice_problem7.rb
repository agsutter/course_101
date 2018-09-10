# Create a hash that expresses the frequency with which each letter occurs in
# this string:

# EXAMPLE:
# => statement = "The Flintstones Rock"
# => { "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }

def letter_count(string)
  array = string.split(//).reject { |item| item == " " }
  array.each_with_object(Hash.new(0)) do |letter, hash|
    hash[letter] += 1
  end
end

statement = "The Flintstones Rock"

p letter_count(statement)
