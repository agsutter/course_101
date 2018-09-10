# Given the array below, turn this array into a hash where the names are
# the keys and the values are the positions in the array.

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

def array_to_hash(array)
  array.each_with_object({}) do |item, new_hash|
    new_hash[item] = array.index(item)
  end
end

p array_to_hash(flintstones)
