require "yaml"

module Termotes
  abstract class Termote
    def self.new(src, x, y, size = 1, fps = nil)
      case src
      when /\.png$/i
        StaticTermote.new StumpyPNG.read(src), x, y
      when /\.gif$/i
        AnimatedTermote.from_gif src, x, y, fps
      else
        path, type = Termotes.get_emote src, size
        if type == "png"
          StaticTermote.new StumpyPNG.read(path), x, y
        else
          AnimatedTermote.from_gif path, x, y, fps
        end
      end
    end
  end
end
