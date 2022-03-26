require 'RMagick'
include Magick

f = Image.new(100,100) do |i|
	i.background_color = "red"
end
f.display
exit