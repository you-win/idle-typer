extends Node2D

export var entity_to_spawn: PackedScene
export var spawn_on_ready: bool = false
export var time_bewtween_spawns: float = 1.0
export var number_to_spawn: int = 1

##
# Builtin functions
##

func _ready():
	$Timer.connect("timeout", self, "_spawn")
	if spawn_on_ready:
		_spawn()

##
# Connections
##

func _on_timeout():
	_spawn()
	if number_to_spawn > 0:
		$Timer.start(time_bewtween_spawns)

##
# Private functions
##

func _spawn():
	var entity_instance = entity_to_spawn.instance()
	entity_instance.global_position = self.global_position
	self.get_parent().call_deferred("add_child", entity_instance)
	self.number_to_spawn -= 1

##
# Public functions
##

func spawn():
	"""
	Allow for other objects to potentially trigger an immediate spawn
	"""
	if number_to_spawn > 0:
		_spawn()

func force_spawn():
	"""
	Allow for other objects to force a spawn regardless of number left
	"""
	LOGGER.info("Number to spawn for " + self.name + ": " + str(self.number_to_spawn))
	_spawn()
