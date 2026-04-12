extends PlayerBase

@onready var stateMachine := $StateMachine
@onready var sprite := $gizmo/sprite
@onready var animationTree := $AnimationTree
@onready var animationTreePlayback : AnimationNodeStateMachinePlayback = animationTree["parameters/playback"]

@onready var coyoteTimer := $CoyoteTimer
@onready var jumpBufferTimer := $JumpBuffer

var shouldWalk := false
var jumpBuffer := false
var coyoteTime := false

func _ready() -> void:
	stateMachine.init("IDLE")

func move(delta):
	var direction := Input.get_axis("ui_left", "ui_right")
	var force := 300
	if sign(velocity.x) != sign(direction):
		force = 600
	velocity.x = move_toward(velocity.x, maxSpeed*direction, delta*force)

func shouldJump():
	return jumpBuffer and (is_on_floor() or coyoteTime)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("jump"):
		jumpBuffer = true
		jumpBufferTimer.start()
	
	stateMachine.process(delta)
	
	gravity(delta)
	sprite.flip_h = shouldFlip(sprite.flip_h)
	rotateSprite(delta)
	
	var onFloor := is_on_floor()
	move_and_slide()
	if is_on_floor() == false and onFloor:
		coyoteTimer.start()
		coyoteTime = true
		
func _on_coyote_timer_timeout() -> void:
	coyoteTime = false

func _on_jump_buffer_timeout() -> void:
	jumpBuffer = false
