extends Node2D

"""
Handles shared game data
"""

const DEBUG: bool = true
const DICTIONARY_PATH: String = "res://assets/words_dictionary.json"
const DICTIONARY_SIZE: int = 370101

var american_dictionary_full: Array = []

var words_in_play: Array = []
var current_input: String = ""

##
# Builtin functions
##

func _ready() -> void:
	if DEBUG:
		LOGGER.info("Starting in debug mode")
	
	# Load the entire American Dictionary into a list
	self.american_dictionary_full = _load_american_dictionary(DICTIONARY_PATH)
	LOGGER.info("American dictionary of size " + str(self.american_dictionary_full.size()) + " loaded.")

func _unhandled_input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

##
# Connections
##

##
# Private functions
##

func _load_american_dictionary(path: String) -> Array:
	"""
	Load a json containing the American dictionary.

	Return an array containing the contents of the json.
	"""
	var file = File.new()
	file.open(path, File.READ)
	var parsed_dictionary = JSON.parse(file.get_as_text()).result.keys()
	assert(parsed_dictionary.size() == DICTIONARY_SIZE)
	file.close()
	return parsed_dictionary

##
# Public functions
##

func get_random_word(scale: int = 0) -> String:
	"""
	Retrieves a random word from the American dictionary
	
	@param scale: Defines a max word length to search for
	If scale is 0, then there is no max word length
	
	@return: A random word that is optionally scaled
	"""

	return ""
