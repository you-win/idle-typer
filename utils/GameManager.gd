extends Node2D

"""
Handles shared game data
"""

var debug = true

var pixel_font: DynamicFont

##
# Builtin functions
##

func _ready() -> void:
	if debug:
		LOGGER.info("Starting in debug mode")

	pixel_font = DynamicFont.new()
	pixel_font.font_data = load("res://assets/Pixeled.ttf")
	pixel_font.size = 16

func _unhandled_input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

##
# Connections
##

##
# Private functions
##

##
# Public functions
##
