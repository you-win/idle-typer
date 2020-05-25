extends Node2D

onready var base: Label = $Base
onready var top: Label = $Top

var text_to_type: String = ""

##
# Builtin functions
##

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var new_visible_characters = 0
	var current_input_length = GameManager.current_input.length()
	if(current_input_length > 0 and not current_input_length > text_to_type.length()):
		for i in current_input_length:
			if text_to_type[i] == GameManager.current_input[i]:
				new_visible_characters += 1
			else:
				new_visible_characters = 0
				break
	top.visible_characters = new_visible_characters

##
# Connections
##

##
# Private functions
##

##
# Public functions
##

func initialize_labels(label_text: String) -> void:
	text_to_type = label_text
	base.text = label_text
	top.text = label_text
