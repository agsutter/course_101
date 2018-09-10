# In the array find the index of the first name that starts with "Be"

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

def find_index_with_each(array, letters)
  array.each do |item|
    return array.index(item) if item.start_with?(letters)
  end
end

def find_index(array, letters)
  array.index { |item| item.start_with?(letters) }
end

p find_index_with_each(flintstones, "Be")
p find_index_with_each(flintstones, "B")
p find_index_with_each(flintstones, "peb")
p find_index_with_each(flintstones, "Q")

p find_index(flintstones, "Be")
p find_index(flintstones, "B")
p find_index(flintstones, "peb")
p find_index(flintstones, "Q")
