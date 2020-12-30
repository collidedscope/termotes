# Termotes

**Termotes** is a Crystal library that draws Twitch emotes right in your terminal (even animated ones!). It does so with the Unicode block elements ▀ and ▄ (and an assumption that your terminal supports 24-bit color).

The example `montage` program is provided to demonstrate basic usage and results. After running `shards install` to grab the PNG dependency and `make all` to build the examples, running `./montage < examples/pokes` should produce something like the following:

<p align="center"><img src="https://i.imgur.com/kQiWP08.gif" /></p>

Another demonstration for good measure:

<p align="center"><img src="https://i.imgur.com/OZLBtvH.gif" /></p>
