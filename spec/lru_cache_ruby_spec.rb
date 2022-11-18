# frozen_string_literal: true

require 'lru_cache_ruby'
require 'item'

RSpec.describe LruCacheRuby do
  describe '#put' do
    it 'adds an entry to the cache' do
      cache = subject

      key_1 = Item.new('one')
      key_2 = Item.new('two')

      value_1 = Item.new(1)
      value_2 = Item.new(2)

      cache.put(key_1, value_1)
      cache.put(key_2, value_2)

      expect(cache.dump.size).to eq 2
    end

    it 'does not grow beyond set limit (3)' do
      cache = subject

      key_1 = Item.new('one')
      key_2 = Item.new('two')
      key_3 = Item.new('three')
      key_4 = Item.new('four')

      cache.put(key_1, 1)
      cache.put(key_2, 2)
      cache.put(key_3, 3)
      cache.put(key_4, 4)

      expect(cache.dump.size).to eq 3
    end

    it 'expels the least recently used item from the cache' do
      cache = subject

      key_1 = Item.new('one')
      key_2 = Item.new('two')
      key_3 = Item.new('three')
      key_4 = Item.new('four')

      cache.put(key_1, 1)
      cache.put(key_2, 2)
      cache.put(key_3, 3)

      cache.get(key_1)
      cache.get(key_3)

      cache.put(key_4, 4)

      expect(cache.dump.keys.map(&:value)).to eq %w[one three four]
    end
  end
end
