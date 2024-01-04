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


You start the script by telling godot that this is a characterbody and you reference all the important nodes.

```
extends CharacterBody2D


@onready var ray_cast: RayCast2D = $collision_raycast
@onready var anim_tree: AnimationTree = $anim_tree
@onready var anim_tree_properties = $anim_tree.get("parameters/playback")
```

You set the tile_size and walkspeed for your game which in this case are 16x16 and 6.

```
const tile_size: int = 16
var walk_speed: int = 6
```

You make five variables:

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

You make the physics_process function this function runs 60 times per second.

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



