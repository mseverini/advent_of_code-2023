require 'parallel'
class Gardener
    attr_accessor :seeds, :hashes
    def initialize()
        file = File.open("./day5/input.txt")
        
        @seeds = file.readline.split(':')[1].split(' ').map(&:to_i).each_slice(2)
        @mapping_sets = []
        until false
            begin
                line = file.readline
                next unless line[0].match?(/[1-9]/)
                s = []
                until line[0].match(/\n/)
                    s << GardenMapping.new(line.split(' ').map(&:to_i))
                    line=file.readline
                end
                @mapping_sets << s
            rescue EOFError
                @mapping_sets << s
                break
            end
        end
    end

    def find_previous(set, key)
        set.each do |mapping|

            return key - mapping.offset if mapping.include?(key)
        end
        key
    end

    def is_seed(seed)
        @seeds.any? { |s| seed.between?(s[0], s[0]+s[1]-1)}
    end

    def find_min_location()
        min = 0
        while true do
            seed = find_seed(min)
            return min if is_seed(seed)
            min += 1
            print(".") if min %1000000 == 0
        end
    end

    def find_seed(loc)
        @mapping_sets.reverse.reduce(loc) { |acc, h|
            find_previous(h, acc)
        }
    end
end

class GardenMapping
    attr_accessor :range_start, :range_end, :offset
    def initialize(set)
        @range_start = set[0]
        @range_end = set[0] + set[2]
        @offset = set[0] - set[1]
    end

    def include?(key)
        key.between?(@range_start, @range_end-1)
    end
end

pp Gardener.new.find_min_location