require 'byebug'
class Graph
    attr_accessor :graph
    def initialize
        file = File.open("./day8/test.txt")
        @directions = file.readline
        file.readline
        @graph = file.readlines.map do |node|
            arr = node.split(" = ")
            [arr[0], ['L', 'R'].zip(arr[1].scan(/[a-zA-Z]+/)).to_h]
        end.to_h
    end

    def get_steps
        node = "AAA"
        path_position = 0
        steps = 0
        while node != "ZZZ" do
            node = @graph[node][@directions[path_position]]
            path_position = ((path_position + 1 ) < (@directions.length - 1)) ? (path_position + 1) : 0
            steps +=1
        end
        steps
    end
end

pp Graph.new.get_steps