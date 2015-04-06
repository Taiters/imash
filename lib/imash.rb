require "imash/version"
require "chunky_png"
require "digest"
require "pp"

class SizeDivisionException < StandardError
end

module Imash

	def self.convert_color(c)

		c[0] = convert_hue(c[0])
		c[1] = convert_saturation(c[1].to_f/255.0)
		c[2] = convert_value(c[2].to_f/255.0)

		return c
	end

	def self.convert_hue(c)
		c
	end

	def self.convert_saturation(c)
		-(c-1)**2 + 1
	end

	def self.convert_value(c)
		-(c-1)**2 + 1
	end

	def self.generate(string, size=30, div=6)

		unless size % div == 0
			raise SizeDivisionException, "#{size} cannot be divided by #{div}"
		end

		bytes = Digest::SHA1.digest(string).bytes.to_a

		bg = convert_color(bytes.shift(3))
		fg = convert_color(bytes.shift(3))

		bg = ChunkyPNG::Color.from_hsv(*bg)
		fg = ChunkyPNG::Color.from_hsv(*fg)

		seed = bytes.shift(8).each_with_index.inject(0) { |a, b| a | ((b[0] & 0xFF) << b[1]*4) }

		prng = Random.new(seed)

		data = []
		(0...div).each { |y|
			data[y] = []
			(0...(div.to_f/2.0).round).each { |x|
				data[y] << (prng.rand > 0.5)
			}
			rev = data[y].reverse
			rev.shift if div % 2 != 0
			data[y].push(*rev)
		}

		img = ChunkyPNG::Image.new(size,size,bg)

		s = size/div
		data.each_with_index { |row, y| 
			row.each_with_index { |val, x|

				x1 = x*s
				y1 = y*s
				x2 = x1+s
				y2 = y1+s

				img.rect(x1,y1,x2,y2,fg,fg) if val

			}
		}

		return img
	end

end
