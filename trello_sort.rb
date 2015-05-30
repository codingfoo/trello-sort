#!/usr/bin/env ruby

require 'trello'

require_relative "config.rb"

def sort cards
end

user = ARGV[0]

member = Trello::Member.find(user)

boards = member.boards

boards.each_with_index do |board, index|
  puts "[#{index}] #{board.name}" unless board.closed
end
print "Choose a board number[?]: "
board_selection = gets
board_selection.chomp!

board = Trello::Board.find(boards[board_selection.to_i].id)

lists = board.lists

lists.each_with_index do |list, index|
  puts "[#{index}] #{list.name}" unless list.closed
end
print "Choose a list number[?]: "
list_selection = gets
list_selection.chomp!

list = Trello::List.find(lists[list_selection.to_i].id)

sort list.cards
