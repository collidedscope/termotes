module Termotes
  class AnimatedTermote < Termote
    @blockified : Array(Array(String))

    def initialize(frames, @x = 0.0, @y = 0.0, @fps = 30.0)
      @blockified = frames.map { |f| Termotes.blockify f }
      Termotes.register_termote self
    end

    def render
      line = Termotes.line_for @y
      column = Termotes.column_for @x
      start = Time.local

      spawn do
        loop do
          break if Termotes.resized_at > start
          @blockified.each do |frame|
            next if Termotes.resized_at > start
            Termotes.render frame, line, column
            sleep 1 / @fps
          end
        end
      end
    end

    def self.from_gif(path, x, y, fps = nil)
      Dir.mkdir frames = File.tempname
      `ffmpeg -i #{path} -vsync 0 #{frames}/%03d.png 2> /dev/null` # TODO: StumpyGIF

      fps ||= begin
        rate = `ffprobe -v 0 -of csv=p=0 -show_entries stream=r_frame_rate #{path}`
        n, d = rate.split('/').map &.to_f
        n / d
      end
      new Dir["#{frames}/*"].sort.map { |f| StumpyPNG.read f }, x, y, fps
    end
  end
end
