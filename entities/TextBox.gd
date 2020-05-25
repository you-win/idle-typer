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
	var new_display_text: String = ""
	var current_input_length = GameManager.current_input.length()
	if(current_input_length > 0 and not current_input_length > text_to_type.length()):
		var index: int = 0
		for i in current_input_length:
			index = i
			var text = text_to_type[i]
			if text == GameManager.current_input[i]:
				new_display_text += " "
			else:
				new_display_text += text
				break
		for j in range(index + 1, text_to_type.length()):
			new_display_text += text_to_type[j]
	else:
		new_display_text = text_to_type
	top.text = new_display_text

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
