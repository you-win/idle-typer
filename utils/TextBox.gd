extends Node2D

export var text_to_type: String = ""

onready var base: Label = $Base
onready var top: Label = $Top

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

func initialize_labels(label_text: String) -> void:
	base.text = label_text
	top.text = label_text
