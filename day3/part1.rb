def load_input()
    file = File.open("./day3/input.txt")
    file.readlines
end

def has_symbol?(str)
    str.match?(/[\!\@\#\$\%\^\&\*\(\)\_\+\=\-\{\}\|\/\?\<\>]/)
end

def part_numbers(input)
    input.each_with_index.flat_map do |str, index|
        nums = []
        str.scan(/[0-9]+/) do |c|
            nums << [c, $~.offset(0)[0]]
        end
        nums = nums.filter do |num|
            has_symbol?(input[[(index-1),0].max][[(num[1]-1),0].max..[num[1]+num[0].length, str.length].min]) ||
            has_symbol?(input[index][[(num[1]-1),0].max..[num[1]+num[0].length, str.length].min]) ||
            has_symbol?(input[[(index+1),(input.length-1)].min][[(num[1]-1),0].max..[num[1]+num[0].length, str.length].min])
        end
        nums.map(&:first).map(&:to_i)
    end
end
input = load_input
print part_numbers(input).sum
