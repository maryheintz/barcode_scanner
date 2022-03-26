require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/png_outputter'
require 'RMagick'

# This is for the 1 1/7" x 3.5" labels (output needs to be smaller than 252x82)
textsize = 18
ysize = 80
xsize = 250
blank_label = Magick::Image.new(xsize, ysize) do |lbl|
	lbl.background_color = "white"
end
blank_label.write("blank_label.png")

# Scan the barcode
puts "Scan barcode"
string = gets.chomp

# Make barcode image
barcode = Barby::Code128B.new(string).to_png
File.open('tmp.png', 'wb'){ |f| f.write barcode }

# Make text image
annotation = Magick::Draw.new do |text|
	text.gravity = Magick::CenterGravity
	text.pointsize = textsize
	text.undercolor = "white"
	text.fill = "black"
end
image = Magick::Image.new(xsize, ysize/4) do |i|
	i.background_color = "white"
	i.gravity = Magick::SouthGravity
end
image = image.annotate(annotation, 0,0,0,0, "#{string}")
image.write("text.png")

# Drop the barcode image and the text image into the blank label
`composite -gravity center tmp.png blank_label.png output.png`
`composite -gravity south text.png output.png #{string}.png`

# Print a number of labels
3.times do 
	`lpr -P Brother_QL_550 #{string}.png`
end