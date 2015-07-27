require_relative '../app/util/helpers.rb'
require "test/unit"

class TestHelperUtils < Test::Unit::TestCase
  @@test_params = {
    :some => "test",
    :params => "fun"
  }

  @@test_key = "b07a12df7d52e6c118e5d47d3f9e60135b109a1f"

  def test_parameterize
    assert_equal("params=fun&some=test",
                 parameterize(@@test_params))
  end

  def test_generateHash
    result = generateHash(@@test_params, @@test_key)
    expected = "9dbee4513472a65af549a8af1882c3ba50a3ee11"
    assert_equal(result, expected)
  end

  def test_checkHash
    expected = "86f0d0707f65ad51344eae41fd2c6d1576ad7ceb"
    truthy = checkHash(@@test_key, parameterize(@@test_params),
                       expected)


    falsey = checkHash(@@test_key, parameterize(@@test_params),
                       "not going to work")

    assert_equal(truthy, true)
    assert_equal(falsey, false)
  end
end
