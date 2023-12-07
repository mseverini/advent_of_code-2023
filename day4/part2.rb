def load_input()
    file = File.open("./day4/input.txt")
    file.readlines.map do |l|
        arr = l.split(':')
        [arr[0].scan(/[0-9]+/).first, arr[1].split('|').map{|n| n.split(' ')}]
    end.to_h
end

def find_winners(input)
    input.map{ |k, v| [k, v[1].filter{ |x| v[0].include? x}.length]}.to_h
end

def duplicate_winners(input)
    counts = input.keys.map{|k| [k,1]}.to_h
    input.each do |k,v|
        ((k.to_i+1)..(k.to_i+v)).each do |j|
            counts[j.to_s] += counts[k]
        end
    end
    counts
end

pp duplicate_winners(find_winners(load_input)).values.sum