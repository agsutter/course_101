# Add up all of the ages from the Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10,
         "Marilyn" => 22, "Spot" => 237 }

def add_values_in_hash(given_hash)
  value_array = given_hash.each_with_object([]) do |pair, array|
    array << pair.last
  end
  value_array.reduce(:+)
end

def add_hash_values(given_hash)
  given_hash.values.reduce(:+)
end

p add_values_in_hash(ages)
p add_hash_values(ages)
