require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count == num_buckets
    key_hash = key.hash
    bucket = self[key_hash]
    @store[bucket] << key
    @count += 1
  end

  def include?(key)
    key_hash = key.hash
    bucket = self[key_hash]
    @store[bucket].include?(key)
  end

  def remove(key)
    key_hash = key.hash
    bucket = self[key_hash]
    @store[bucket].delete(key)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    num % num_buckets
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(old_store.length * 2) { Array.new }
    @count = 0
    old_store.flatten.each do |el|
      insert(el)
    end
  end
end
