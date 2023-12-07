allowable = {
    red: 12,
    blue: 14,
    green: 13
}

file = File.open("./day2/input.txt")
h = file.readlines.filter do |i| 
    game = i.split(':')
    hashes = game[1].split(';').map{|i| i.strip.split(',').map{ |j| j.split(' ')}.map(&:reverse).to_h}
    hashes.all? {|h| h.all? { |k,v| v.to_i <= allowable[k.to_sym]}}
end

pp h.sum{|i| i.split(':')[0].split(" ")[1].to_i}