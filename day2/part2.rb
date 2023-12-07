
file = File.open("./day2/test_1.txt")
 powers = file.readlines.map do |i| 
    hashes = i.split(':')[1].split(';').map{|i| i.strip.split(',').map{ |j| j.split(' ')}.map(&:reverse).to_h}
    hashes.reduce({"red" => 0, "green" => 0, "blue" => 0}) do |r, h|
        r.merge(h) {|key, old, new| old > new.to_i ? old : new.to_i}
    end.values.reduce(&:*)
end
pp powers.sum
