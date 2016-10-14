require 'helper'

class Conformist::HashStructTest < Minitest::Test
  def test_initialize
    assert_equal({:a => 1}, HashStruct.new({:a => 1}).attributes)
    assert_empty HashStruct.new.attributes
  end

  def test_delegates
    hash = HashStruct.new
    assert hash.respond_to?(:[])
    assert hash.respond_to?(:[]=)
    assert hash.respond_to?(:fetch)
    assert hash.respond_to?(:key?)
  end

  def test_equality
    hash1 = HashStruct.new :a => 1
    hash2 = HashStruct.new :a => 1
    hash3 = Minitest::Mock.new
    hash3.expect :attributes, {:a => 1}
    hash3.expect :class, Minitest::Mock
    assert_equal hash1, hash2
    refute_equal hash1, hash3
  end

  def test_readers_with_method_missing
    hash = HashStruct.new :a => 1, :c_d => 1
    assert_equal 1, hash.a
    assert_equal 1, hash.c_d
  end

  if respond_to? :respond_to_missing? # Compatible with 1.9
    def test_readers_with_respond_to_missing
      hash = HashStruct.new :a => 1, :c_d => 1
      assert hash.respond_to?(:a)
      assert hash.respond_to?(:c_d)
    end
  end
end
