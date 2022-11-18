# frozen_string_literal: true

class LinkedList
  attr_accessor :head, :start

  def initialize
    @head = nil
    @start = nil
  end

  def push(item)
    @head = item if @head.nil?

    @start = item if @start.nil?

    prev_item = @head

    raise 'Not a new item!' unless item.right.nil?

    return unless prev_item != item

    prev_item.right = item
    item.left = prev_item
    @head = item
  end

  def delete(item)
    @start = item.right if @start == item

    @head = item.right if @head == item

    next_item = item.right
    prev_item = item.left

    if !next_item.nil? || !prev_item.nil?
      prev_item.right = next_item if prev_item
      next_item.left = prev_item if next_item
    end

    item.left = item.right = nil
  end

  def traverse
    item = @start

    list = []

    until item.nil?
      list << item.value
      item = item.right
    end

    list
  end

  def oldest_key
    @start
  end

  def move_to_end(item)
    prev_item = item.left
    next_item = item.right

    @head = item.left if item == @head

    @start = item.right if item == @start

    item.right = nil
    item.left = @head if @head != item

    prev_item.right = next_item if prev_item
    next_item.left = prev_item if next_item
  end
end
