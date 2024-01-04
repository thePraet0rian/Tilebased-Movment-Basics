### This is a "simple" tutorial for Tilebase Movement:


## The Player Scene:


![](/res/player_scn.png)

The player scene is made up of:
- A character body.
- A sprite
- A ray_cast for collisions.
- An animation_player
- An animation_tree


## The Player Script:


``
extends CharacterBody2D


@onready var ray_cast: RayCast2D = $collision_raycast
@onready var anim_tree: AnimationTree = $anim_tree
@onready var anim_tree_properties = $anim_tree.get("parameters/playback")
``

- You start the script by telling godot that this is a characterbody and you reference all important nodes.

``
const tile_size: int = 16
var walk_speed: int = 6
``
- You set the tile_size for you game which is 16x16 in this case and the walk speed which is 6.

``
var inital_position: Vector2 = Vector2.ZERO
var input_direction: Vector2 = Vector2.ZERO
var previous_position: Vector2 = Vector2.ZERO
``




