# Various Themes for Benchpress. Also look into Gruff themes.
# https://github.com/topfunky/gruff/blob/master/lib/gruff/themes.rb

module Benchpress
  class Themes

    # Simple light background with Primary colors.
    PLAIN = {
      background_colors: %w(#ff0000 #00ff00),
      background_direction: :top_bottom,
      colors: %w(#ff0000 #00ff00 #0000ff #fff000 #000fff #ffff00 #00ffff #ff00ff),
      marker_color: '#000000'
    }
  end
end
