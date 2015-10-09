require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if map.include?(key)
      link = map.get(key)
      value = link.val
      link.delete

      store.insert_link(link)
    else
      value = @prc.call(key)
      prev_link = store.insert(key, value)
      map.set(key, prev_link)
    end

    eject! if self.count > @max

    value
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  attr_reader :map, :store

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
  end

  def eject!
  end
end
