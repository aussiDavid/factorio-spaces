# frozen_string_literal: true

# Adds width and height dimentions to items
class Spaces
  def self.call(*args)
    new(*args).process
  end

  def initialize(graph = {})
    @graph = graph
  end

  def process
    return {} if graph.empty?
    return point_item unless items?

    graph.merge(items: new_items, width: 5, height: 3)
  end

  private

  def graph
    return {} unless @graph

    @graph.transform_keys(&:to_sym)
  end

  def items?
    items.size.positive?
  end

  def items
    graph[:items]
  end

  def point_item
    graph.merge(width: 1, height: 1)
  end

  def new_items
    items.map { |item| self.class.call(item) }
  end
end
