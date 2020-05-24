extends Node2D

"""
Handles shared game data
"""

const DEBUG: bool = true
const DICTIONARY_PATH: String = "res://assets/words_dictionary.json"
const DICTIONARY_SIZE: int = 370101
const STARTING_MAX_WORD_LENGTH: int = 4

# Uses the current time as a seed, according to the docs
var rng = RandomNumberGenerator.new()

var full_dictionary: Array = []
var scaled_dictionary: Dictionary = {}

var words_in_play: Array = []
var current_input: String = ""

##
# Builtin functions
##

func _ready() -> void:
	if DEBUG:
		LOGGER.info("Starting in debug mode")
	
	rng.randomize()
	
	# Load the entire dictionary into a list
	self.full_dictionary = _load_dictionary(DICTIONARY_PATH)
	self.scaled_dictionary = _scale_dictionary(self.full_dictionary)
	
	if DEBUG:
		LOGGER.info("Using seed " + str(rng.seed))
		LOGGER.info("Dictionary of size " + str(self.full_dictionary.size()) + " loaded.")
		LOGGER.info("Random word: " + self.get_random_word(3))

func _unhandled_input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

##
# Connections
##

##
# Private functions
##

func _load_dictionary(path: String) -> Array:
	"""
	Load a json containing a dictionary.

	Return an array containing the contents of the json.
	"""
	var file = File.new()
	file.open(path, File.READ)
	var parsed_dictionary = JSON.parse(file.get_as_text()).result.keys()
	assert(parsed_dictionary.size() == DICTIONARY_SIZE)
	file.close()
	return parsed_dictionary

func _scale_dictionary(dictionary: Array) -> Dictionary:
	"""
	Sorts words into levels based on length
	
	@param dictionary: The list of dictionary words being sorted
	
	@return: A dictionary data structure of sorted dictionary words
	"""
	var temp_dictionary: Dictionary = {}
	
	for i in range(0, 5):
		temp_dictionary[i] = _find_words_up_to_given_length(STARTING_MAX_WORD_LENGTH + i)
	
	return temp_dictionary

func _find_words_up_to_given_length(length: int) -> Array:
	"""
	Sort words into levels.
	
	The first level catches words from length 1-4 while each increasing
	level catches words of a certain length.
	
	@param length: The length of the word to find
	
	@return: An array of all words that match the search criteria
	"""
	var words: Array = []
	
	if length == STARTING_MAX_WORD_LENGTH:
		for word in self.full_dictionary:
			if word.length() <= length:
				words.append(word)
	else:
		for word in self.full_dictionary:
			if word.length() == length:
				words.append(word)
	
	return words

func _get_random_word_from_scaled_dictionary(scale: int) -> String:
	"""
	Generates a random integer and pulls that to pull a word from the given
	dictionary scale
	
	@param scale: The scale to use when generating a random number and for
	searching in the scaled dictionary
	
	@return: A random word by given scale
	"""
	var random_number: int = rng.randi_range(0, scaled_dictionary[scale].size())
	return scaled_dictionary[scale][random_number]

##
# Public functions
##

func get_random_word(scale: int = -1) -> String:
	"""
	Retrieves a random word from the dictionary
	
	@param scale: Defines a max word length to search for
	If scale is -1, then there is no max word length
	@TODO Will break if the scale is not expected but whatever
	
	@return: A random word that is optionally scaled
	"""
	if scale >= 0:
		return _get_random_word_from_scaled_dictionary(scale)
	else:
		var random_number: int = rng.randi_range(0, DICTIONARY_SIZE)
		return full_dictionary[random_number]
