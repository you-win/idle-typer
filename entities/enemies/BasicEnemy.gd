class_name BasicEnemy

extends KinematicBody2D

export var speed: float = 20.0

var spawner: String
var move_point: Vector2
var label_text: String

var velocity: Vector2 = Vector2.ZERO

onready var text_box = $TextBox

##
# Builtin functions
##

func _ready() -> void:
	text_box.initialize_labels(label_text)
	
	PubSub.subscribe(GameManager.PUBSUB_KEYS.ENEMY_KILLED, self)

func _physics_process(delta: float) -> void:
	if (self.move_point - self.global_position).length() > 5:
		self.velocity = (self.move_point - self.global_position).normalized() * self.speed
		self.velocity = self.move_and_slide(velocity)

##
# Connections
##

##
# Private functions
##

func _cleanup_enemy() -> void:
	PubSub.publish(GameManager.PUBSUB_KEYS.ENEMY_KILLED_SPAWNER, self.spawner)
	PubSub.unsubscribe(self, GameManager.PUBSUB_KEYS.ENEMY_KILLED)
	self.queue_free()

##
# Public functions
##

func event_published(event_key: String, payload):
	match event_key:
		GameManager.PUBSUB_KEYS.ENEMY_KILLED:
			if payload == self.label_text:
				_cleanup_enemy()
		_:
			pass
