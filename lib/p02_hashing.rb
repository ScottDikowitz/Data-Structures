class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_return = "101"
    self.each do |el|
      hash_return = el.hash.to_s + hash_return
    end
    hash_return.to_i
  end
end

class String
  def hash
    if self.length <= 1
      return self.ord
    else
      self.chars.hash
    end

  end
end

class Hash
  def hash
    hash_return = 0
    self.each do |key, value|
      hash_return += (key.hash + value.hash)
    end
    hash_return
  end
end
