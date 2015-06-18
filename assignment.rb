# 1.2-Countries

puts %{
  Welcome to the file parser and formatter.

  Please input the name of the countries file
  currently stored in the same folder as this 
  script.

}
print ">> "
file_name = gets.chomp

'''
# For testing purposes, creating an array with special cases
all_lines = ["MK|macedonia, the former yugoslav republic of", "FK|falkland islands (malvinas)"]
'''
# Create an array with the words that should not be capitalized
lowercase_words = ['and', 'of', 'the']


puts "Now attempting to open file: #{file_name}\n\n"

# Create an empty array to hold all of the lines, then push each line in the file to it
all_lines = []
File.open(file_name).each do |line|
  all_lines.push(line)
end

puts "Processing the file\n\n"

all_index = 0

# Perform the following logic on each line
all_lines.each do |line|
  
  # Replace pipe with different formatting
  line.gsub!('|', ' - ')

  # Turn each line string into an array of the words based on spaces
  line_arr = line.split(' ')

  # Create a variable to keep the index on the line_arr
  index = 0

  # Perform the logic on each line array
  line_arr.each do |word|

    # Capitalize each word in the array except the ones in the lowercase_words array
    unless lowercase_words.include?(word)
      word.capitalize!
    end

    # Sometimes, a country's name is like macedonia, the former yugoslave republic of
    # This logic should capitalize the first "the" after the comma, which is actually
    # the first word in the countries name.
    prior = index - 1
    if line_arr[prior][-1] == ',' && word == 'the'
      word.capitalize!
    end

    # Sometimes, a country has a name in parentheses after the actual name, like this
    # FK|falkland islands (malvinas)
    # This logic should capitalize this word as well.
    if word[0] == '('
      word_arr = word.split('')
      word_arr[1].upcase!
      word = word_arr.join('')
      line_arr[index] = word
    end

    # Uptick index
    index += 1

  end

  # The first "word" in each line array is an abbreviation that should have both
  # characters capitalized
  line_arr[0].upcase!

  # Reconnect the line array into a string.
  line = line_arr.join(' ')
  all_lines[all_index] = line
  all_index += 1
end

File.new("updated_#{file_name}", "w+")
File.open("updated_#{file_name}", "w+") do |write|
  write.puts(all_lines)
end

puts "This file contains a list representing #{all_lines.length} countries.\n\n"
puts "A new file called updated_#{file_name} has been created in the same folder"
puts "as this script. The following printout is what has been saved in this file.\n\n"

all_lines.each { |line| puts line }

