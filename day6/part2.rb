require 'byebug'
class Races
    attr_accessor :races
    def initialize
        file = File.open("./day6/input.txt")
        
        time = file.readline.scan(/[0-9]+/).join('').to_i
        distance = file.readline.scan(/[0-9]+/).join('').to_i
        @race = Race.new(time, distance)
    end

    def find_bounds

        (find_bound(@race, @race.time, @race.time/2) - find_bound(@race, 1, @race.time/2) + 1)

    end

    def find_bound(race, prefered, bound)
        middle = (bound - (bound-prefered)/2).abs.ceil

        if (bound - prefered).abs == 1 
            return race.win?(prefered) ? prefered : bound
        end

        return race.win?(middle) ? find_bound(race, prefered, middle) : find_bound(race, middle, bound)
    end
end

class Race 
    attr_accessor :time
    def initialize(time, distance)
        @time = time
        @record_distance = distance
    end

    def win?(hold_time)
        run_time = time - hold_time
        velocity = hold_time
        distance = velocity * run_time
        distance > @record_distance
    end
end

pp Races.new.find_bounds