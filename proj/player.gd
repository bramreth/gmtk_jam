extends KinematicBody2D

export(OpenSimplexNoise) var noise
var time = 0

var tile_size = 128
var abs_pos = position

var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

onready var ray = $RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE # * tile_size/2
	abs_pos = position


func _physics_process(delta):
	time += delta * 100
	var flicker = noise.get_noise_1d(time) / 10.0
	$Light2D.scale = Vector2(1 + flicker, 1 + flicker)

func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)
			
func move(dir):
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding() and !$CurveTween.is_active():
		$CurveTween.play(0.08, position, position + inputs[dir] * tile_size)
#		position += inputs[dir] * tile_size


func _on_CurveTween_curve_tween(sat):
	position = sat
