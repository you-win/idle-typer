extends Node2D

export var text_to_type: String = ""

onready var base: Label = $Base
onready var top: Label = $Top

##
# Builtin functions
##

func _ready() -> void:
	base.text = self.text_to_type
	top.text = self.text_to_type

##
# Connections
##

##
# Private functions
##

##
# Public functions
##


