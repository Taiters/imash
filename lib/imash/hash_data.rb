module Imash
	class HashData

		attr_reader :seed, :bg, :fg, :mirror_y

		def initialize(hash)

			bytes = hash.bytes.to_a

			@fg   = convert_fg(*bytes.shift(3))
			@bg   = convert_bg(*bytes.shift(3))

			@fg[0] = (((@bg[0].to_f / 255.0) + (@fg[0].to_f/255.0) / 3.33) * 255.0) % 255

			@seed = bytes.shift(8).each_with_index.inject(0) { |a, b| 
				a | ((b[0] & 0xFF) << b[1]*8) 
			}
			@mirror_y = (bytes.shift.to_f / 255.0) > 0.25

		end

		private

		def convert_fg(h,s,v)

			s = s.to_f/255.0
			v = v.to_f/255.0

			s = 0.95 - (s-1)**2/5.0
			v = 0.75 - (v-1)**2/10.0

			return [h,s,v]
		end

		def convert_bg(h,s,v)

			s = s.to_f/255.0
			v = v.to_f/255.0

			s = 0.5 + s**2/5.0
			v = 0.3 + v**2/5.0

			return [h,s,v]
		end

	end
end