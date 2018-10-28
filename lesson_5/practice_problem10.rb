# Given the following data structure and without modifying the original
# array, use the map method to return a new array identical in structure
# to the original but where the value of each integer is incremented by 1.

arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

plus_one = arr.map do |sub_hash|
  sub_hash.transform_values { |v| v += 1 }
end

p plus_one