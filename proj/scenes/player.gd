extends KinematicBody2D

signal moved(pos)
export(OpenSimplexNoise) var noise
var time = 0
var is_dead = false
var tile_size = 128
var abs_pos = position

var current_stip = GameManager.stipulation.NONE

var active_interactible = null
var underneath_tile = null

var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

var spawn_point = Vector2()

onready var ray = $RayCast2D
onready var animation_player = $animation_player

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.player = self
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE # * tile_size/2
	abs_pos = position

func set_spawn_point(spawn_point):
	self.spawn_point = spawn_point
	respawn()

func _physics_process(delta):
	time += delta * 100
	var flicker = noise.get_noise_1d(time) / 10.0
	$Light2D.scale = Vector2(1 + flicker, 1 + flicker)

func _unhandled_input(event):
	if GameManager.hud_active or is_dead: return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)
			
func move(dir):
	if $CurveTween.is_active(): return
	match dir:
		"down": 
			$Sprite.animation = "walk_down"
			$Sprite.play()
		"up": 
			$Sprite.animation = "walk_down"
			$Sprite.play()
		
	match current_stip:
		GameManager.stipulation.FAST:
			ray.cast_to = inputs[dir] * tile_size
			update_selection()
			$CurveTween.play(0.08, position, position + deep_raycast(inputs[dir], 1))
		_:
			ray.cast_to = inputs[dir] * tile_size
			update_selection()
			if !ray.is_colliding():
				$CurveTween.play(0.2, position, position + inputs[dir] * tile_size)
			else:
				$Sprite.animation = "default"
		#		position += inputs[dir] * tile_size
	
func deep_raycast(dir, multiple):
	ray.cast_to = dir * multiple * tile_size
	update_selection()
	if !ray.is_colliding():
		return deep_raycast(dir, multiple + 1)
	else:
		return dir * (multiple - 1) * tile_size


func _on_CurveTween_curve_tween(sat):
	position = sat

func update_selection():
	ray.force_raycast_update()
	active_interactible = null
	if ray.get_collider():
		if ray.get_collider().get("is_interactible"):
			active_interactible = ray.get_collider()

func _on_CurveTween_tween_completed(object, key):
	update_selection()
	emit_signal("moved", position)
	$Sprite.animation = "default"
	
func die(death_type):
	is_dead = true
	match (death_type):
		Deaths.Type.Fire:
			animation_player.play("fire_death")
			pass
		Deaths.Type.Acid:
			animation_player.play("acid_death")
			pass

func respawn():
	is_dead = false
	position = spawn_point

func dance():
	animation_player.play("dance_1")
	
func end_dance():
	animation_player.stop()
	animation_player.seek(0, true)
