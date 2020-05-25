extends Node2D

onready var line_edit = $LineEdit

##
# Builtin functions
##

func _ready() -> void:
	PubSub.subscribe(GameManager.PUBSUB_KEYS.ENEMY_KILLED, self)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if _is_valid_input(line_edit.text):
			# Spawner does not subscribe to this
			# Spawner subscribes to ENEMY_KILLED_SPAWNER since there can be
			# multiple enemies with the same word
			PubSub.publish(GameManager.PUBSUB_KEYS.ENEMY_KILLED, line_edit.text)
			line_edit.text = ""

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

func event_published(event_key: String, payload):
	match event_key:
		_:
			pass
