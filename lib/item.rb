# frozen_string_literal: true

class Item
  attr_accessor :value, :right, :left

  def initialize(value)
    @value = value
  end
end
