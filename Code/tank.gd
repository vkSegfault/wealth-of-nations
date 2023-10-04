extends CharacterBody2D

@export var movement_speed: float = 20.0

@export var movement_target: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# path and target don't need to match perfectly to consider them as successfully reached target (do small variation may apply)
	$NavigationAgent2D.path_desired_distance = 4.0
	$NavigationAgent2D.target_desired_distance = 4.0

	call_deferred("_actor_setup")

@warning_ignore("unused_parameter")
func _process(delta):
	if $NavigationAgent2D.is_navigation_finished():
		return
	
	# where our tank is right now
	var current_agent_position: Vector2 = global_position
	
	# where is the next point the tank should go (not end location - just something in between)
	var next_path_position: Vector2 = $NavigationAgent2D.get_next_path_position()
	
	# direction
	var direction: Vector2 = next_path_position - current_agent_position
	
	# normalizing so direction is without it's "strength"
	direction = direction.normalized()
	direction = direction * movement_speed
	
	# velecity is buil-in variable for current node and we set it
	velocity = direction
	
	# update position based on built-in 'velocity' variable
	move_and_slide()
			

func _actor_setup():
	# wait until first frame finish
	await get_tree().physics_frame
	
	_set_movement_target(movement_target.position)

func _set_movement_target(target_point: Vector2):
	$NavigationAgent2D.target_position = target_point
