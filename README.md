# This is a "simple" tutorial for Tilebase Movement:


## The Player Scene:


![](/res/player_scn.png)

The player scene is made up of:
- A character body
- A sprite
- A ray_cast for collisions.
- An animation_player
- An animation_tree


## The Player Script:


####You start the script by telling godot that this is a characterbody and you reference all the important nodes.

```
extends CharacterBody2D

@onready var ray_cast: RayCast2D = $collision_raycast
@onready var anim_tree: AnimationTree = $anim_tree
@onready var anim_tree_properties = $anim_tree.get("parameters/playback")
```

####You set the tile_size and walkspeed for your game which in this case are 16x16 and 6.

```
const tile_size: int = 16
var walk_speed: int = 6
```

####You make five variables:

- inital_position: this is the players position before he walks
- input_direction: this is the direction you want to go
- is_moving: this is whether or not you are moving
- is_running: this is whether or not you are running or walking
- percent_moved: this is how much you have already moved in the direction you want do go


```
var inital_position: Vector2 = Vector2.ZERO
var input_direction: Vector2 = Vector2.ZERO

var is_moving: bool = false
var is_running: bool = false
var percent_moved: float = 0.0
```

####You make the physics_process function this function runs 60 times per second:

1. If the player hasn't input anything he is not moving so player_input() executes
2. If the player has input something move(delta) executes
3. animation() always executes

```
func _physics_process(delta: float) -> void:

    if not is_moving: 
		player_input()
	elif is_moving:
		move(delta)
	
	animation()
```

####You make the variable next_step and the function player_input():

- To ensure that the player does not move diagonaly you have two if statements, that check whether or not the other input_direction is 0
- input_direction: get_axis, if both actions are pressed this returns 0 so the player does not move if the first one is pressed it returns -1 if the other action is pressed it returns +1.
- next_step: the direction you want to move in and the tile_size
- Now you have to check if there is anything in that direction so you set the targetposition of the raycast to the next step
- You have to force_raycast_update so it checks.
- if ui_select is pressed you set is_running true and double the walk_speed
- if the raycast doesn't collied with anything and the player has made an input the initial_position is set to the current_position and the player is set to move.

```

func player_input() -> void:
	
	if input_direction.y == 0:
		input_direction.x = Input.get_axis("ui_left", "ui_right")
	if input_direction.x == 0:
		input_direction.y = Input.get_axis("ui_up", "ui_down")
	
	next_step = input_direction * tile_size
	
	ray_cast.target_position = next_step
	ray_cast.force_raycast_update()
	
	if Input.is_action_pressed("ui_select"):
		is_running = true
		walk_speed = 12
	else:
		is_running = false
		walk_speed = 6
	
	
	if not ray_cast.is_colliding():
		if input_direction != Vector2.ZERO:
			
			inital_position = position
			is_moving = true
```


####You make to move(delta) funtion.

- percent_moved is set to the walk_speed * delta, delta is the time since the last frame
- you check whether or not percent_moved is over 100% if it is you set is_moving to false, the position to the position your supposed to have and reset the percent_moved variable to 0.0
- if percent_moved isn't 100% you set the position to the initial_position + plus the step you supposed to take but times the percent_moved so the progress you've made

```
func move(delta: float) -> void:
	
	percent_moved += walk_speed * delta
	
	if percent_moved >= 1.0:
		
		position = inital_position + next_step
		percent_moved = 0.0
		is_moving = false
	
	else:
		
		position = inital_position + (tile_size * input_direction * percent_moved)

```

####You make the animation function()

- if the input_direction isn't 0 you set the blend positions of the animation_tree
- you check whether you are running or walking and then travel to the state you want
- if your input_direction is 0 then you just play the idle animation

```
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
```

####How to setup animations:

1. You press the "Animation" button then click new and enter a name.
2. Then you click on your sprite node, go to the animation property, select a frame and then press the key next to it
3. You enter all frames you want set the time and set it to loop.

![](/res/animation.png)
