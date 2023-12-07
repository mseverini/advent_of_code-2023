class Gardener
    attr_accessor :seeds, :hashes
    def initialize()
        file = File.open("./day5/input.txt")
        
        @seeds = file.readline.split(':')[1].split(' ')
        @mapping_sets = []
        until false
            begin
                line = file.readline
                next unless line[0].match?(/[1-9]/)
                s = []
                until line[0].match(/\n/)
                    print('.')
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

    def find_next(set, key)
        set.each do |mapping|
            return key - mapping.offset if mapping.include?(key)
        end
        key
    end

    def find_min_location()
        @seeds.map{ |seed|
            print("\n")
            @mapping_sets.reduce(seed.to_i) { |acc, h|
                print("#{acc}->")
                find_next(h, acc)
            }
        }.min
    end
end

class GardenMapping
    attr_accessor :range_start, :range_end, :offset
    def initialize(set)
        @range_start = set[1]
        @range_end = set[1] + set[2]
        @offset = set[1] - set[0]
    end

    def include?(key)
        key.between?(@range_start, @range_end)
    end
end

pp Gardener.new.find_min_location