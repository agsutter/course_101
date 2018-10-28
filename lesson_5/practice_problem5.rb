# Given this nested Hash, figure out the total age of just the male members of the family.

munsters = {"Herman" => { "age" => 32, "gender" => "male" },
            "Lily" => { "age" => 30, "gender" => "female" },
            "Grandpa" => { "age" => 402, "gender" => "male" },
            "Eddie" => { "age" => 10, "gender" => "male" },
            "Marilyn" => { "age" => 23, "gender" => "female"}
          }

munsters.each do |k, v|
  male_ages_total += munsters[k]['age'] if munsters[k]['gender'] == 'male'
end

p male_ages_total
