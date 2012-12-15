require "socket"
require 'cuid/version'
begin
  require "securerandom"
rescue LoadError
end

##
# Cuid is a library for generating unique collision-resistant IDs optimized for horizontal scaling and performance
#
# @example Generate a hash
#   hash = Cuid::generate #=> "ch8qypsnz0000a4welw8anyr"
#
# @example Generate 2 hashes
#   hashes = Cuid::generate(2) #=> ["ch8qyq35f0002a4wekjcwmh30", "ch8qyq35f0003a4weewy22izq"]
#
# @see http://github.com/dilvie/cuid Original author's detailed explanation of the cuid spec

module Cuid
  ##
  # @private
  @count = 0
  
  ##
  # length of each segment of the hash
  BLOCK_SIZE = 4

  ##
  # size of the alphabet (e.g. base36 is [a-z0-9])
  BASE = 36

  ##
  # @private
  # maximum number that can be stored in a block of the specified size using the specified alphabet
  DISCRETE_VALUES = (BASE ** BLOCK_SIZE) - 1

  ##
  # size of the random segment of the block
  RAND_SIZE = BLOCK_SIZE * 2

  ##
  # @private
  # maximum number that can be stored in the random block
  RAND_MAX = (BASE ** RAND_SIZE) - 1

  ##
  # @private
  # minimum number that can be stored in the random block (otherwise it will be too short)
  RAND_MIN = BASE ** (RAND_SIZE - 1)

  ##
  # @private
  # first letter of the hash
  LETTER = "c"

  class << self

    ##
    # Returns one or more hashes based on the parameter supplied
    # 
    # @overload generate()
    #   Returns one hash when called with no parameters or a parameter of 1
    # 
    #   @param [optional, Integer] quantity determines number of hashes returned (must be nil, 0 or 1)
    #   @return [String]
    #
    # @overload generate(quantity)
    #   Returns an array of hashes when called with a parameter greater than 1
    #   
    #   @param [Integer] quantity determines number of hashes returned (must be greater than 1)
    #   @return [Array<String>]
    #
    # @overload generate(quantity,secure_random)
    #   Returns an array of hashes when called with a parameter greater than 1
    #
    #   @param [Integer] quantity determines number of hashes returned (must be greater than 1)
    #   @param [Boolean] secure_random attempts to use SecureRandom if set to True (Ruby 1.9.2 and up; reverts to Kernel#rand if SecureRandom is not supported)
    def generate(quantity=1,secure_random=false)
      @use_secure_random = secure_random
      @fingerprint = get_fingerprint # only need to get the fingerprint once because it is constant per-run
      return api unless quantity > 1

      values = Array(1.upto(quantity)) # create an array of the correct size
      return values.collect { api } # fill array with hashes
    end

    ##
    # Validates (minimally) the supplied string is in the correct format to be a hash
    #
    # Validation checks that the first letter is correct and that the rest of the
    # string is the correct length and consists of lower case letters and numbers.
    # 
    # @param [String] str string to check
    # @return [Boolean] returns true if the format is correct
    def validate(str)
      blen = BLOCK_SIZE * 6
      !!str.match(/#{LETTER}[a-z0-9]{#{blen}}/)
    end
   
    private

    ##
    # Collects and asssembles the pieces into the actual hash string.
    #
    # @private
    def api
      timestamp = (Time.now.to_f * 1000).truncate.to_s(BASE)

      random = get_random_block

      @count = @count % DISCRETE_VALUES
      counter = pad(@count.to_s(BASE))

      @count += 1
      
      return (LETTER + timestamp + counter + @fingerprint + random)
    end
    
    ##
    # Returns a string which has been converted to the correct size alphabet as defined in
    # the BASE constant (e.g. base36) and then padded or trimmed to the correct length.
    #
    # @private
    def format(text,size=BLOCK_SIZE)
      base36_text = text.to_s(BASE)
      return (base36_text.length > size) ? trim(base36_text,size) : pad(base36_text,size)
    end

    ##
    # Returns a string trimmed to the length supplied or BLOCK_SIZE if no length is supplied.
    #
    # @private
    def trim(text,max=BLOCK_SIZE)
      original_length = text.length
      return text[original_length-max,max]
    end

    ##
    # Returns a string right-justified and padded with zeroes up to the length supplied or
    # BLOCK_SIZE if no length is supplied.
    #
    # @private
    def pad(text,size=BLOCK_SIZE)
      return text.rjust(size,"0")
    end

    ##
    # Generates a random string.
    #
    # @private
    def get_random_block
      @secure_random = defined?(SecureRandom) if @secure_random.nil?
      if @secure_random && @use_secure_random then
        number = SecureRandom.random_number(RAND_MAX - RAND_MIN) + RAND_MIN
      else
        number = ((rand * (RAND_MAX - RAND_MIN)) + RAND_MIN)
      end
      return number.truncate.to_s(BASE)
    end

    ##
    # Assembles the host fingerprint based on the hostname and the PID.
    #
    # @private
    def get_fingerprint
      padding = 2
      hostname = Socket.gethostname
      hostid = hostname.split('').inject(hostname.length+BASE) do |a,i|
        a += (i.respond_to? "ord") ? i.ord : i[0]
      end
      return format($$, padding) + format(hostid, padding)
    end

  end
end
