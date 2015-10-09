class Link
  attr_accessor :key, :val, :next, :previous

  def initialize(key = nil, val = nil, nxt = nil, prv = nil)
    @key, @val, @next, @previous = key, val, nxt, prv
  end

  def delete
    #puts self, self.previous, self.next
    self.previous.next, self.next.previous = self.next, self.previous

    self.next, self.previous = nil, nil
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable
  attr_reader :head, :tail

  def initialize
    @head = Link.new
    @tail = Link.new
    head.next = @tail
    tail.previous = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    head.next
  end

  def last
    tail.previous
  end

  def empty?
    head.next == tail
  end

  def get(key)
    self.each do |link|
      return link.val if link.key == key
    end
    nil
  end

  def insert_link(new_link)
    last.next = new_link
    @tail.previous = new_link
    new_link.previous = last
    new_link.next = tail
    new_link
  end

  def include?(key)
    self.any? { |link| link.key == key }
  end

  def insert(key, val)
    # self.last.next = Link.new(key, val)
    new_link = Link.new(key, val, tail, last)
    last.next = new_link
    @tail.previous = new_link
    new_link
  end

  def remove(key)
    self.each do |link|
      if link.key == key
        link.delete
        break
      end
    end
  end

  def each
    nxt = first
    until nxt == tail
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
