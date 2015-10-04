#!/usr/bin/ruby

# Self-study notes: Ruby Collections 

theArray = [1, 2, 3, 4, 5]
theHash = { 1 => '1', 2 => '2', 3 => '3', 4 => '4', 5 => '5' }

# Can I work out how to transform an array into a Hash? Indeed, I can :) 
def array_to_hash(sourceArray)
	sourceArray.inject({}) do |targetHash, value|
		targetHash.merge(value => value.to_s)
	end
end

# Can I work out how to transform a Hash into an array? Again, yes.
def hash_to_array(sourceHash)
	sourceHash.keys.to_ary # Nice to see that keys in a Hash retain insertion order 
end

# Iterate over the source in chunks of the specified size (yes, it's pretty much Enumerable.each_slice).
# It was also my "ah-hah" moment for Ruby; I can see the appeal of using it to quickly try out ideas
def each_chunk(source, chunkSize, &action)
	throw "Where's the iterable source?"	if source == nil # At first, this syntax seemed a bit weird, but it's growing on me 
	throw "Don't be ridiculous"				if chunkSize < 1
	throw 'Nothing do do'					if action == nil

	chunkIndex = 0
	currentChunk = []
	source.each do |value|
		currentChunk.push value

		if currentChunk.size == chunkSize
			action.call currentChunk, chunkIndex
			currentChunk.clear

			chunkIndex += 1
		end
	end

	# Remaining values
	action.call currentChunk, chunkIndex unless currentChunk.empty?
end
