require "socket"
require 'cuid/version'

module Cuid
  @count = 0
  BLOCK_SIZE = 4
  BASE = 36
  DISCRETE_VALUES = BASE ** BLOCK_SIZE
  RAND_SIZE = BLOCK_SIZE * 2
  RAND_MAX = BASE ** RAND_SIZE
  RAND_MIN = BASE ** (RAND_SIZE - 1)
  LETTER = "c"

  class << self

    def generate(repeat=0)
      @fingerprint = get_fingerprint
      return api unless repeat > 0

      values = Array(1.upto(repeat))
      return values.collect { api }
    end

    def validate(str)
      blen = BLOCK_SIZE * 6
      !!str.match(/#{LETTER}[a-z0-9]{#{blen}}/)
    end
   
    private

    def api
      timestamp = (Time.now.to_f * 1000).truncate.to_s(BASE)

      random = get_random_block

      @count = @count % DISCRETE_VALUES
      counter = pad(@count.to_s(BASE))

      @count += 1
      
      return (LETTER + timestamp + counter + @fingerprint + random)
    end
    
    def format(text,size=BLOCK_SIZE)
      base36_text = text.to_s(BASE)
      return (base36_text.length > size) ? trim(base36_text,size) : pad(base36_text,size)
    end
      
    def trim(text,max=BLOCK_SIZE)
      original_length = text.length
      return text[original_length-max,max]
    end

    def pad(text,size=BLOCK_SIZE)
      return text.rjust(size,"0")
    end

    def get_random_block
      return ((rand * (RAND_MAX - RAND_MIN)) + RAND_MIN).truncate.to_s(BASE)
    end

    def get_fingerprint
      padding = 2
      hostname = Socket.gethostname
      hostid = hostname.split('').inject(hostname.length+BASE) { |a,i| a += i.ord }
      return format($$, padding) + format(hostid, padding)
    end

  end
end
