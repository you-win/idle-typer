extends Node2D

onready var line_edit = $LineEdit

##
# Builtin functions
##

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if _is_valid_input(line_edit.text):
			pass

##
# Connections
##

##
# Private functions
##

func _is_valid_input(text: String) -> bool:
	if GameManager.words_in_play.has(text):
		return true
	return false

##
# Public functions
##


