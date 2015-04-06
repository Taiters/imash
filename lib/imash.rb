require "imash/version"
require "imash/hash_data"
require "imash/generator"
require "chunky_png"
require "digest"
require "pp"

class SizeDivisionException < StandardError
end

module Imash

	def self.generate(string, size=30, divisions=6)

		unless size % divisions == 0
			raise SizeDivisionException, "#{size} cannot be divided by #{divisions}"
		end

		hash = Digest::SHA1.digest(string)

		data = Imash::HashData.new(hash)

		return Imash::Generator.generate(data, size, divisions)

	end
end
