require 'RMagick'
txt = Magick::Draw.new
txt.gravity = Magick::CenterGravity
txt.pointsize = 12
txt.undercolor = "white"
txt.fill = "black"
image = Magick::Image.new(252,15) do |i|
    i.background_color = 'white'
    i.gravity = Magick::SouthGravity
end
image.annotate(txt, 0,0,0,0, '20LLCHI10V42135')
image.write('text.png')
