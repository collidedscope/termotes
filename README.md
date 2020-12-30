# Termotes

**Termotes** is a Crystal library that draws Twitch emotes (or indeed any GIF/PNG files) right in your terminal! It does so with the Unicode block elements ▀ and ▄ in order to paint *two whole pixels* per character cell.

The example `montage` program is provided to demonstrate basic usage and results. After running `shards install` to grab [the PNG dependency](https://github.com/stumpycr/stumpy_png) and `make all` to build the examples, executing `./montage < examples/pokes` should produce something like the following:

<p align="center"><img src="https://i.imgur.com/kQiWP08.gif" /></p>

Another demonstration for good measure:

<p align="center"><img src="https://i.imgur.com/OZLBtvH.gif" /></p>

Full disclosure: these images showcase idealized scenarios; while the render loop does go out of its way to gracefully respond to changes in window size (either via explicit resizing or {in,de}creasing the font size), the transition can be a little jarring in practice. Please see [this video](https://collidedscope.github.io/termotes/demo.mp4) for a more realistic run.
