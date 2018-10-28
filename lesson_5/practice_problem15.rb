# Given this data structure write some code to return an array which contains
# only the hashes where all the integers are even.

arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

# This is my code. I read the above prompt as "return each key-value pair where
# the array is comprised of only even numbers," therefore the following is returned:
# => [{}, {:b=>[2, 4, 6], :d=>[4]}, {:e=>[8], :f=>[6, 10]}] 
arr.map do |sub_hash|
  sub_hash.select do |_, v|
    v.all? do |num|
      num.even?
    end
  end
end

# This is the Launch School code which returns the following:
# => [{:e=>[8], :f=>[6, 10]}]
arr.select do |hsh|
  hsh.all? do |_, value|
    value.all? do |num|
      num.even?
    end
  end
end
