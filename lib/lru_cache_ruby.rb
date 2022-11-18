# frozen_string_literal: true

require 'linked_list'

class LruCacheRuby
  MAX_SIZE = 3

  def initialize
    @cache = {}
    @list = LinkedList.new
  end

  def put(key, value)
    if @cache.size == MAX_SIZE
      key_to_drop = @list.oldest_key
      @list.delete(key_to_drop)
      @cache.delete(key_to_drop)

      @cache[key] = value
      @list.push(key)
    else
      @list.push(key)
      @cache[key] = value
    end
  end

  def get(key)
    @list.move_to_end(key)
    @cache[key]
  end

  def dump
    @cache
  end

  def purge
    @cache = {}
    @list = LinkedList.new
  end
end
