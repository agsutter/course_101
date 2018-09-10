# Pick out the minimum age from our current Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10,
         "Marilyn" => 22, "Spot" => 237 }

def minimum_age(given_hash)
  values_hash = given_hash.values
  current_value = values_hash[0]
  values_hash.each do |age|
    current_value = age if age < current_value
  end
  current_value
end

p minimum_age(ages)
