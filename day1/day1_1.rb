file = File.open("./day1/input.txt")
nums = file.readlines.map do |i| 
    arr = i.chars.filter{ |c| c =~ /[1-9]/ }
    (arr[0]+arr[-1]).to_i
end
puts nums
