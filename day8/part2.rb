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
        path_position = 0
        steps = 0
        until nodes.all? { |n| n.match /..Z/ } do
            nodes = nodes.map{ |n| @graph[n][@directions[path_position]] }
            path_position = ((path_position + 1 ) < (@directions.length - 1)) ? (path_position + 1) : 0
            steps +=1
            print '.' if steps % 100000 == 0
        end
        steps
    end
end

pp Graph.new.get_steps