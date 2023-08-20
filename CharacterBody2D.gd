extends CharacterBody2D

# Stałe prędkości i siły skoku
const SPEED = 300
const JUMP_FORCE = -250

# Grawitacja
const GRAVITY = 100

# Własna zmienna do przechowywania prędkości
var custom_velocity = Vector2(0, 0)

# Limit kamery
var camera_limits = Rect2()

func _ready():
# Pobierz obszar widoc	zny kamery jako limit ruchu
	camera_limits = $MainCamera.get_viewport_rect()

func _physics_process(delta):
	# Sterowanie postacią za pomocą klawiszy
	custom_velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		custom_velocity.x += SPEED
	if Input.is_action_pressed("ui_left"):
		custom_velocity.x -= SPEED
	if is_on_floor() and Input.is_action_pressed("ui_up"):
		custom_velocity.y = JUMP_FORCE

	# Dodaj grawitację
	custom_velocity.y += GRAVITY * delta
	print(custom_velocity)

	# Porusz postacią
	velocity = custom_velocity
	move_and_slide()
	custom_velocity = velocity
	
	# Ograniczenie kamery
	var position = global_position
	if position.x < camera_limits.position.x:
		position.x = camera_limits.position.x
	elif position.x > camera_limits.position.x + camera_limits.size.x:
		position.x = camera_limits.position.x + camera_limits.size.x

#	if position.y < camera_limits.position.y:
#		position.y = camera_limits.position.y
#	elif position.y > camera_limits.position.y + camera_limits.size.y:
#		position.y = camera_limits.position.y + camera_limits.size.y

	global_position = position
