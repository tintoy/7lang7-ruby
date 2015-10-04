#!/usr/bin/ruby

# Self-study notes for 7 languages in 7 weeks: Ruby

class Tree
	# Declare class properties (seems kinda clumsy to me). 
	attr_accessor :node_name, :children # Yep, ":identifier" syntax is indeed an identity thing

	def initialize(name, children=[])
		@node_name = name
		@children = children
	end

	def visit_all(&block)
		visit &block
		children.each do |child|
			child.visit_all &block
		end
	end

	def visit(&block)
		block.call self
	end
end

# AF: Don't know how to declare static methods on classes yet (I'm assuming you can)

# Create a single root node from a Hash 
def hash_to_tree_node(hash)
	throw 'Must supply a hash' if hash == nil
	throw 'Cannot have multiple root nodes' if hash.size > 1

	root_node_key	= hash.keys.first
	root_node_value = hash[root_node_key] if root_node_key != nil
	root_node = Tree.new(
		root_node_key,
		children = hash_to_tree_nodes(root_node_value)
	) if root_node_value != nil

	root_node
end

# Recursively convert the keys / values from a Hash into tree nodes
def hash_to_tree_nodes(hash)
	nodes = []

	unless hash == nil
		hash.each do |key, value|
			nodes.push(
				Tree.new(key, hash_to_tree_nodes(value))
			)
		end
	end

	nodes
end

puts
puts 'Building tree from nested Hashes'
my_tree = hash_to_tree_node({
	'Ruby' => {
		'Reia' => nil,
		'MacRuby' => nil
	}
})

puts
puts 'Visiting a node'
my_tree.visit do |node|
	puts node.node_name
end

puts
puts 'Visiting entire tree'
my_tree.visit_all do |node|
	puts node.node_name
end
