# In this hash of people and their age,

#   ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# see if "Spot" is present.

# Bonus: What are two other hash methods that would work just as well for this solution?

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

def format(heading)
  puts "=> #{heading.upcase}:"
end

def find_name(hash, name)
  name = name.capitalize
  output = hash.fetch(name, "#{name} isn't here!")
  return "#{name} is #{output} years old." if hash.keys.include?(name)
  output
end

format('Method One')
p ages["Spot"]
p ages["Herman"]

format('Method Two')
puts find_name(ages, 'spot')
puts find_name(ages, 'lily')
puts find_name(ages, 'eddie')
puts find_name(ages, 'hubert')

format('Method Three')
p ages.has_key?("Spot")
p ages.has_key?("Herman")
p ages.has_key?("lily")

format('Method Four')
p ages.include?("Spot")
p ages.include?("Herman")
p ages.include?("lily")