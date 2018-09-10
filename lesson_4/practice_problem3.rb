# In the age hash, throw out the really old people (age 100 or older).

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

def no_old_people(given_hash)
  given_hash.reject { |_, value| value >= 100 }
end

p no_old_people(ages)
