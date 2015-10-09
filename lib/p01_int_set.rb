class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    p @store[num]
    @store[num]
  end

  private

  def is_valid?(num)
   num.between?(0, @store.length)

  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = num % @store.length
    @store[bucket] << num
  end

  def remove(num)
    bucket = num % @store.length
    @store[bucket].delete(num)
  end

  def include?(num)
    bucket = num % @store.length
    @store[bucket].include?(num)

  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if @store.length == @count
      resize!
    end
    bucket = self[num]
    @store[bucket] << num
    @count += 1
  end

  def remove(num)
    bucket = self[num]
    @store[bucket].delete(num)
    @count -= 1
  end

  def include?(num)
    bucket = self[num]
    @store[bucket].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    num % @store.length

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
