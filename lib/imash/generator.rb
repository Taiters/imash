module Imash
	module Generator

		def self.generate(hash_data, size, divisions)

			prng = Random.new(hash_data.seed)

			data = []
			(0...divisions).each { |y|
				data[y] = []
				(0...(divisions.to_f/2.0).round).each { |x|
					data[y] << (prng.rand > 0.5)
				}
				rev = data[y].reverse
				rev.shift if divisions % 2 != 0
				data[y].push(*rev)
			}

			fg = ChunkyPNG::Color.from_hsl(*hash_data.fg)
			bg = ChunkyPNG::Color.from_hsl(*hash_data.bg)

			img = ChunkyPNG::Image.new(size,size,bg)

			s = size/(divisions+2)
			data.each_with_index { |row, y| 
				row.each_with_index { |val, x|

					x1 = x*s+s
					y1 = y*s+s
					x2 = x1+s
					y2 = y1+s

					img.rect(x1,y1,x2,y2,fg,fg) if val

				}
			}

			return img

		end

	end
end