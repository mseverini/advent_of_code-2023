def load_input()
    file = File.open("./day3/input.txt")
    file.readlines
end

def is_gear?(str)
    str.match?(/[\*]/)
end

def get_adjacents(nums, loc)
    nums.filter do |num|
        num[1].between?(loc[0]-num[0].length,loc[0]+1) and num[2].between?(loc[1]-1, loc[1]+1)
    end.map(&:first).map(&:to_i)
end

def part_numbers(input)
    nums = []
    input.each_with_index.flat_map do |str, index|
        str.scan(/[0-9]+/) do |c|
            nums << [c, $~.offset(0)[0], index]
        end
    end
    gears = []
    input.each_with_index.flat_map do |str, index|
        str.scan(/[*]/) do |c|
            gears << [$~.offset(0)[0], index]
        end
    end
    gears.map do |gear|
        get_adjacents(nums,gear)
    end.filter{|n| n.length == 2}.map{|n| n.reduce(:*)}
end
input = load_input
print part_numbers(input).sum
