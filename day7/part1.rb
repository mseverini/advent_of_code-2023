require 'byebug'
class Poker
    def initialize
        file = File.open("./day7/input.txt")
        @hands = file.readlines.map{|hand| Hand.new(hand)}
    end

    def get_winnings
        @hands.sort.each_with_index.reduce(0) { |winnings, hand| (hand[0].bid.to_i * (hand[1] +1)) + winnings }
        # @hands.sort.each_with_index.map { |hand, index| [hand.bid.to_i, (index + 1)] }
    end
end

class Hand
    attr_accessor :type, :hand, :bid
    def initialize(hand)
        @hand, @bid = hand.split(" ")
        @type = get_type_rank
        byebug if @type == nil
    end

    TYPE_RANKS = {
        '5' => 7,
        '41' => 6,
        '32' => 5,
        '311' => 4,
        '221' => 3,
        '2111' => 2,
        '11111' => 1
    }

    CARD_RANKS = {
        "T" => 10,
        "J" => 11,
        "Q" => 12,
        "K" => 13,
        "A" => 14
    }

    def get_type_rank
        TYPE_RANKS[@hand.chars.tally.values.sort.reverse!.join]
    end

    def <=> (other_hand)
        return type <=> other_hand.type  if type != other_hand.type
        hand.chars.zip(other_hand.hand.chars).each do |pair|
            return  CARD_RANKS.fetch(pair[0], pair[0].to_i) <=> CARD_RANKS.fetch(pair[1], pair[1].to_i) if pair[0] != pair[1]
        end
        return 0
    end
end

pp Poker.new.get_winnings