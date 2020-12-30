module Termotes
  alias Pixel = Tuple(UInt8, UInt8, UInt8, UInt8)
  @@blocks = Channel(String).new

  def blockify(canvas) : Array(String)
    i = 1
    strips = Array.new(2) { [] of Slice(Pixel) }
    canvas.each_row do |row|
      strips[i = 1 - i] << row.map &.to_rgba
    end

    if strips[1].size < strips[0].size
      strips[1] << strips[1][-1]
    end

    strips.transpose.map { |(top, bot)|
      String.build do |str|
        top.zip bot do |(tr, tg, tb, ta), (br, bg, bb, ba)|
          tf = ta / 255
          bf = ba / 255
          t = {tr * tf, tg * tf, tb * tf}
          b = {br * bf, bg * bf, bb * bf}

          str << case {tf, bf}
          when {0, 0}
            ' '
          when {_, 0}
            "\e[38;2;%d;%d;%dm▄\e[m" % t
          when {0, _}
            "\e[38;2;%d;%d;%dm▀\e[m" % b
          else
            "\e[48;2;%d;%d;%d#{t == b ? "m " : ";38;2;%d;%d;%dm▄" % b}\e[m" % t
          end
        end
      end
    }
  end

  def render(blocks, line, column)
    spawn do
      blocks.each_with_index do |row, i|
        @@blocks.send "\e[#{line + i};#{column}H" + row
      end
    end
  end

  def render_loop
    loop { puts @@blocks.receive }
  end
end
