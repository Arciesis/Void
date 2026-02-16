extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -500.0
const DASH_SPEED = 1500 # Not useful yet but I keep it for later use
var has_dashed : bool = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if is_on_floor() or is_on_wall():
		has_dashed = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Handle dash.
	if Input.is_action_just_pressed("dash") and not has_dashed:
		has_dashed = true
		var dash_direction = (get_global_mouse_position() - global_position).normalized()
		velocity.y = move_toward(velocity.y, dash_direction.y * SPEED, DASH_SPEED)
		velocity.x = move_toward(velocity.x, dash_direction.x * DASH_SPEED, DASH_SPEED)
		print(dash_direction.x)
		print(velocity.x)
		print()
	
	move_and_slide()
