# Termotes

**Termotes** is a Crystal library that draws Twitch emotes (or indeed any GIF/PNG files) right in your terminal! It does so with the Unicode block elements ▀ and ▄ in order to paint *two whole pixels* per character cell.

The example `montage` program is provided to demonstrate basic usage and results. After running `shards install` to grab [the PNG dependency](https://github.com/stumpycr/stumpy_png) and `make all` to build the examples, executing `./montage < examples/pokes` should produce something like the following:

<p align="center"><img src="https://i.imgur.com/kQiWP08.gif" /></p>

Another demonstration for good measure:

<p align="center"><img src="https://i.imgur.com/OZLBtvH.gif" /></p>

Full disclosure: these images showcase idealized scenarios; while the render loop does go out of its way to gracefully respond to changes in window size (either via explicit resizing or {in,de}creasing the font size), the transition can be a little jarring in practice. Please see [this video](https://collidedscope.github.io/termotes/demo.mp4) for a more realistic run.

## Usage

The primary entry point is `Termotes::Termote.new`, a "virtual" initializer that returns either a `StaticTermote` or an `AnimatedTermote`. You can pass in all sorts of things:

```crystal
require "termotes"
alias Tmote = Termotes::Termote

# static Twitch emote of size 2 (can be 1-3) at top-center
a = Tmote.new "KEKW", x: 0.5, y: 0.0, size: 2
# animated Twitch emote at bottom-right with FPS auto-detected by ffmpeg
b = Tmote.new "ThisIsFine", 0.9, 0.85, 3

# local PNG roughly centered horizontally and vertically
c = Tmote.new "lenna.png", x: 0.5, y: 0.5
# local GIF at the top-left going very fast
d = Tmote.new "/some/local/meme.gif", fps: 88.0

[a, b, c, d].each &.render
Termotes.render_loop
```

Once created, a `Termote` must then be added to the registry by invoking its `#render` method. After all desired emotes have been rendered, invoke `Termotes.render_loop` to start the show. This method fires off an infinite loop that continually renders animation frames in addition to listening for changes to the size of the terminal and re-rendering as necessary. Invoke it in a `spawn` block if you need to retain control of your program.

**Note well** that drawing pixels in the terminal requires much more (physical) space than most other graphics environments; while this library handles larger inputs just fine, you'll almost certainly want to be using a terminal emulator that allows you to decrease its font size on the fly.
