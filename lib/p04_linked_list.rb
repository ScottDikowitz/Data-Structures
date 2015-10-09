class Link
  attr_accessor :key, :val, :next

  def initialize(key = nil, val = nil, nxt = nil)
    @key, @val, @next = key, val, nxt
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable
  attr_reader :head

  def initialize
    @head = Link.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    head.next
  end

  def last
    return @head if empty?
    self.each do |link|
      return link if link.next.nil?
    end
  end

  def empty?
    head.next.nil?
  end

  def get(key)
    self.each do |link|
      return link.val if link.key == key
    end
    nil
  end

  def include?(key)
    self.any? do |link|
      link.key == key
    end


  end

  def insert(key, val)
    self.last.next = Link.new(key, val)
  end

  def remove(key)
    last = head
    self.each do |link|
      if link.key == key
        nxt = link.next
        last.next = nxt
        link.next = nil
        break
      end
      last = link
    end
  end

  def each
    nxt = first
    until nxt.nil?
      yield(nxt)
      nxt = nxt.next
    end

    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
