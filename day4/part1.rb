def load_input()
    file = File.open("./day4/input.txt")
    file.readlines.map do |l|
        l.split(':')[1].split('|').map{|n| n.split(' ')}
    end
end

pp load_input.sum{|r| (2**(r[1].filter{|x| r[0].include? x}.length-1)).floor}