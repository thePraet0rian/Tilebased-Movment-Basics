extends CharacterBody2D


@onready var ray_cast: RayCast2D = $collision_raycast
@onready var anim_tree: AnimationTree = $anim_tree
@onready var anim_tree_properties = $anim_tree.get("parameters/playback")

const tile_size: int = 16
var walk_speed: int = 6

var inital_position: Vector2 = position
var input_direction: Vector2 = Vector2.ZERO

var is_moving: bool = false
var is_running: bool = false
var percent_moved: float = 0.0


func _physics_process(delta: float) -> void:
	
	if not is_moving: 
		player_input()
	elif is_moving:
		move(delta)

	
	animation()


var next_step: Vector2


func player_input() -> void:
	
	if input_direction.y == 0:
		input_direction.x = Input.get_axis("ui_left", "ui_right")
	
	if input_direction.x == 0:
		input_direction.y = Input.get_axis("ui_up", "ui_down")
	
	next_step = input_direction * tile_size
	ray_cast.target_position = next_step
	ray_cast.force_raycast_update()
	
	if not ray_cast.is_colliding():
		if input_direction != Vector2.ZERO:
			
			inital_position = position
			is_moving = true


func move(delta: float) -> void:
	
	percent_moved += walk_speed * delta
	
	if percent_moved >= 1.0:
		
		position = inital_position + next_step
		percent_moved = 0.0
		is_moving = false
	
	else:
		
		position = inital_position + (tile_size * input_direction * percent_moved)


func animation() -> void:
	
	if input_direction != Vector2.ZERO:
		
		anim_tree.set("parameters/idle/blend_position", input_direction)
		anim_tree.set("parameters/run/blend_position", input_direction)
		anim_tree.set("parameters/walk/blend_position", input_direction)
		
		if is_running:
			
			anim_tree_properties.travel("run")
		else:
			
			anim_tree_properties.travel("walk")
	else:
		
		anim_tree_properties.travel("idle")
