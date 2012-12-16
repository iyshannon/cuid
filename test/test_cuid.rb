require 'cuid'
require 'test/unit'

class CuidTest < Test::Unit::TestCase
  def test_generate_string
    c = Cuid::generate
    assert c.is_a? String
  end

  def test_generate_array
    c = Cuid::generate(3)
    assert c.is_a? Array
    assert_equal 3, c.size
  end

  def test_generate_format
    c = Cuid::generate
    assert_equal 25, c.length
    assert c.start_with? "c"
  end

  def test_validate_true
    c = Cuid::generate
    assert Cuid::validate(c)
  end

  def test_validate_false
    c = "d00000000000000000000"
    assert !Cuid::validate(c)
  end

  def test_collision
    results = {}
    collision = false
    c = Cuid::generate(600000)
    c.each do |e|
      collision = true if results[e]
      results[e] = true
    end
    assert !collision
  end

  def test_secure_random
    results = {}
    collision = false
    c = Cuid::generate(1000,true)
    c.each do |e|
      collision = true if results[e]
      results[e] = true
    end
    assert !collision
  end

  def test_version
    assert_nothing_raised { Cuid::VERSION }
  end
end

