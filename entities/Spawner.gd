extends Node2D

export var entity_to_spawn: PackedScene
export var spawn_on_ready: bool = false
export var time_bewtween_spawns: float = 1.0
export var number_to_spawn: int = 1
export var move_point_name: String = "Default"

export var current_scale: int = 0

var move_point_vector: Vector2

##
# Builtin functions
##

func _ready():
	move_point_vector = _get_move_point()
	$Timer.connect("timeout", self, "_spawn")
	PubSub.subscribe(GameManager.PUBSUB_KEYS.ENEMY_KILLED_SPAWNER, self)
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

func _spawn() -> void:
	var entity_instance: BasicEnemy = entity_to_spawn.instance()
	
	var random_word = GameManager.get_random_word(self.current_scale)
	var should_loop = true
	while should_loop:
		if GameManager.words_in_play.has(random_word):
			random_word = GameManager.get_random_word(self.current_scale)
		else:
			should_loop = false
	
	entity_instance.global_position = self.global_position
	entity_instance.label_text = random_word
	entity_instance.spawner = self.name
	entity_instance.move_point = _get_move_point()
	GameManager.words_in_play.append(entity_instance.label_text)
	
	# Each screen has a node of Spawners and a Ysort node
	# Spawners need to get the parent of the parent (base screen) and find the YSort
	self.get_parent().get_parent().get_node("YSort").call_deferred("add_child", entity_instance)
#	self.get_parent().call_deferred("add_child", entity_instance)
	self.number_to_spawn -= 1

func _get_move_point() -> Vector2:
	var temp_vec: Vector2
	for node in get_parent().get_parent().get_node("MovePoints").get_children():
		if node.move_point_name == self.move_point_name:
			temp_vec = node.global_position
	if temp_vec == null:
		temp_vec = Vector2.ZERO
	return temp_vec

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

func event_published(event_key: String, payload):
	match event_key:
		GameManager.PUBSUB_KEYS.ENEMY_KILLED_SPAWNER:
			if payload == self.name:
				self._spawn()
