require "termotes"

print "Which emote would you like to see in all three sizes? "
emote = gets.not_nil!

smol    = Termotes::Termote.new emote, x: 0.0, y: 0.0, size: 1
meatyum = Termotes::Termote.new emote, x: 0.1, y: 0.0, size: 2
yuge    = Termotes::Termote.new emote, x: 0.3, y: 0.0, size: 3

[smol, meatyum, yuge].each &.render
Termotes.render_loop
