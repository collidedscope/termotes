module Termotes
  class StaticTermote < Termote
    def initialize(canvas, @x : Float64, @y : Float64)
      @blocks = Termotes.blockify canvas
      Termotes.register_termote self
    end

    def render
      line = Termotes.line_for @y
      column = Termotes.column_for @x
      Termotes.render @blocks, line, column
    end
  end
end
