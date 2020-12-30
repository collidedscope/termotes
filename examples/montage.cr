require "termotes"

width, height, size = gets.not_nil!.split.map &.to_i
emotes = Array.new(width * height) { gets.not_nil! }

emotes.shuffle.map_with_index { |emote, i|
  x = i % width / width
  y = i // width / height
  Termotes::Termote.new emote, x, y, size
}.each &.render

Termotes.render_loop
