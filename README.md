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


- You start the script by telling godot that this is a characterbody and you reference all the important nodes.
```
extends CharacterBody2D


@onready var ray_cast: RayCast2D = $collision_raycast
@onready var anim_tree: AnimationTree = $anim_tree
@onready var anim_tree_properties = $anim_tree.get("parameters/playback")
```

- You set the tile_size and walkspeed for your game which are 16x16 and 6.

```
const tile_size: int = 16
var walk_speed: int = 6
```

Then you make five variables:

- inital_position this is the players position before he walks
- input_direction this tells godot which direction you want to go.
- is_moving this tells godot whether or not you are moving
- is_running this tells godot whether or not you are running or walking
- percent_moved this tells godot how much you have already moved in the direction you want do go

Note: 
- percent_moved is between 0 and 1 so 0.0 = 0% and 1.0 = 100%

```
var inital_position: Vector2
var input_direction: Vector2 = Vector2.ZERO

var is_moving: bool = false
var is_running: bool = false
var percent_moved: float = 0.0
```




