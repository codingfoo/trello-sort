#!/usr/bin/env ruby
require 'pp'
require 'trello'

require_relative "config.rb"

user_id = ARGV[0]

member = Trello::Member.find(user_id)

boards = member.boards

puts 'Boards'
boards.each_with_index do |board, index|
  puts "[#{index}] #{board.name}" unless board.closed
end
print "Choose a board number[?]: "
board_selection = $stdin.gets
board_selection.chomp!

board = Trello::Board.find(boards[board_selection.to_i].id)

lists = board.lists

puts
puts 'Lists'
lists.each_with_index do |list, index|
  puts "[#{index}] #{list.name}" unless list.closed?
end
print "Choose a list number[?]: "
list_selection = $stdin.gets
list_selection.chomp!

list = Trello::List.find(lists[list_selection.to_i].id)

cards = list.cards

results = cards.sort do |a,b|
  puts
  puts "[1] #{a.name}"
  puts "[2] #{b.name}"
  print "Which has a higher priority?: "
  card_selection = $stdin.gets.chomp!.to_i
  puts
  next 1 if card_selection == 1
  next -1 if card_selection == 2
end

puts 'Sorted Cards:'

results.reverse.each_with_index do |card, index|
  puts "#{card.name}"
  card.pos = index
  card.save
end
