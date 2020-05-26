extends Reference

var words: Big = Big.new(0)
var words_multiplier: float = 1.0

var letters: Big = Big.new(0)

##
# Builtin functions
##

func _ready() -> void:
	pass

##
# Connections
##

##
# Private functions
##

##
# Public functions
##

func increase_words(amount: float) -> void:
	self.words.plus(amount * self.words_multiplier)

func increase_letters(amount: int) -> void:
	self.letters.plus(amount)
