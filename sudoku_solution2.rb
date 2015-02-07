game1_board_string = "1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--"

def flatten_array(board_string)
  array = board_string.split('')
  array.map do |place|
    if place == "-"
      place
    else
      place = place.to_i
    end
  end
end

def two_d_array(board_string)
  pass_in_array = flatten_array(board_string)
  Array.new(9) { pass_in_array.shift(9) }
end

def possibilities(row_index, column_index, board_string)
  board_array = two_d_array(board_string)
  possible = board_array[row_index][column_index]
  return possible if possible.is_a? Integer # Will return true for everything?

  (get_row_possibilities(row_index, board_string) &
   get_col_possibilities(column_index, board_string) &
   get_box_possibilities(row_index, column_index, board_string))
end

def get_row_possibilities(row_index, board_string)
  board_array = two_d_array(board_string)
  all_possibilities = (1..9).to_a
  row_possibilities = board_array[row_index]
  final_possibilities = all_possibilities - row_possibilities
end

def get_col_possibilities(column_index, board_string)
  board_array = two_d_array(board_string).transpose
  all_possibilities = (1..9).to_a
  column_possibilities = board_array[column_index]
  final_possibilities = all_possibilities - column_possibilities
end

def box_index(row_index, column_index)
  box_index = ((row_index / 3) * 3) + ( column_index / 3)
end

def get_box_possibilities(row_index, column_index, board_string)
  board_array = two_d_array(board_string)
  box = box_index(row_index, column_index)
  all_possibilities = (1..9).to_a
  current_box = []
  3.times do |row|
    3.times do |column|
      board_array[row][column]
      current_box << board_array[row + (box / 3)*3][column + (box % 3)*3]
    end
  end
  all_possibilities -= (all_possibilities & current_box)
end

def find_next_blank(board_string, element_position=0)
  flat_array = flatten_array(board_string)
  element_position.upto(board_string.length) do |current_position|
    return current_position if flat_array[current_position] == '-'
  end
end

def solver(board_string, element_position = 0, current_pass=1)
  puts "enter solver: #{element_position} "
  board_array_flat = flatten_array(board_string)
  board_array = two_d_array(board_string)

  row_index = element_position / 9
  column_index = element_position % 9





  return board_array if element_position.nil?

  #.tap{|x| p "current solutions: #{x} pass: #{current_pass} col: #{col} row_index: #olumn_indexow_index}" olumn_index
  p solutions = possibilities(row_index, column_index, board_string)

  # if solutions == []
  #    return nil
  p board_array
  if board_array_flat[element_position] != "-"
    solver(board_string, element_position + 1)
  elsif solutions.length > 1
    solutions.each do |guess|
      board_array_flat[element_position] = guess
      new_possible_board_array = []
      board_array_flat.each do |element|
        new_possible_board_array << element
        new_possible_game_string = new_possible_board_array.join('')
        solver(new_possible_game_string, element_position + 1) if new_possible_game_string.length == 81
      end
    end
  elsif solutions.length == 1
    board_array_flat[element_position] = solutions[0]
    new_possible_board_array = []
    board_array_flat.each do |element|
        new_possible_board_array << element
        new_possible_game_string = new_possible_board_array.join('')
        solver(new_possible_game_string, element_position + 1) if new_possible_game_string.length == 81
      end

  else
    return p 'HEY THIS IS BROKE'
  end
end


solver(game1_board_string)

#   else
#     solutions.each do |guesser|
#       flat_array[element_position] = guesser.tap{|x| p "Current guess: #{x}"}
#       solver(board_string, element_position + 1, current_pass + 1)
#     end
#   end

#   puts "end of line"
#   board_array
# end

solver(game1_board_string)
