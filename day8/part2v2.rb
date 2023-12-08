require 'byebug'
class Graph
    attr_accessor :graph
    def initialize
        file = File.open("./day8/test.txt")
        @directions = file.readline
        file.readline
        @graph = file.readlines.map do |node|
            arr = node.split(" = ")
            [arr[0], ['L', 'R'].zip(arr[1].scan(/[0-9a-zA-Z]+/)).to_h]
        end.to_h
    end

    def get_steps
        nodes = @graph.keys.filter { |k| k.match /..A/ }
        nodes.map{ |n| get_z_distance(n)}.reduce(1, :lcm) 
    end

    def get_z_distance(node)
        path_position = 0
        steps = 0
        while !node.match /..Z/ do
            node = @graph[node][@directions[path_position]]
            path_position = ((path_position + 1 ) < (@directions.length - 1)) ? (path_position + 1) : 0
            steps +=1
        end
        steps
    end
end

pp Graph.new.get_steps