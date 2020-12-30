require "http/client"
require "stumpy_png"

module Termotes
  @@termotes = [] of Termote
  class_property \
    lines = 0,
    columns = 0,
    resized_at = Time.local,
    have_ffmpeg = Process.find_executable "ffmpeg"

  update_dimensons

  Signal::WINCH.trap do
    @@resized_at = Time.local
    update_dimensons
    rerender
  end

  extend self

  def register_termote(termote)
    @@termotes << termote
  end

  def update_dimensons
    @@lines = `tput lines`.to_i
    @@columns = `tput cols`.to_i
  end

  def line_for(y)
    (@@lines * y).to_i + 1
  end

  def column_for(x)
    (@@columns * x).to_i + 1
  end

  def rerender
    print "\e[H\e[2J" # clear terminal
    @@termotes.each &.render
  end

  def cache_dir
    ENV["XDG_CACHE_HOME"]? || File.join ENV["HOME"], ".cache"
  end

  EMOTE_CACHE = File.join cache_dir, "termotes"
  %w[1x 2x 3x].each { |size| Dir.mkdir_p File.join EMOTE_CACHE, size }

  EMOTES = Hash(String, {String, String}).from_yaml \
    File.read(File.expand_path "../data/emotes.yaml", __DIR__)

  CLIENT = HTTP::Client.new URI.parse "https://cdn.betterttv.net"

  def get_emote(code, size)
    emote = EMOTES[code]?
    abort "no such emote '#{code}'" unless emote

    id, type = emote
    path = File.join EMOTE_CACHE, "#{size}x", "#{id}.#{type}"

    unless File.exists? path
      resp = CLIENT.get "/emote/#{id}/#{size}x"
      File.write path, resp.body
    end

    {path, type}
  end
end

require "termotes/termote"
require "termotes/*"
