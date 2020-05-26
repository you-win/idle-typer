extends CanvasLayer

##
# Builtin functions
##

func _ready() -> void:
	_update_words_label()
	_update_letters_label()

func _process(_delta: float) -> void:
	_update_words_label()
	_update_letters_label()

##
# Connections
##

##
# Private functions
##

func _update_words_label() -> void:
	$MarginContainer/OuterVBox/CounterVBox/WordsLabelContainer/WordsLabel.text = "Words: " + GameManager.player_data.words.toString()

func _update_letters_label() -> void:
	$MarginContainer/OuterVBox/CounterVBox/LettersLabelContainer/LettersLabel.text = "Letters: " + GameManager.player_data.letters.toString()

##
# Public functions
##

func event_published(event_key: String, payload) -> void:
	match event_key:
		_:
			pass
