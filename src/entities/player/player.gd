extends PlayerBase

@onready var stateMachine := $StateMachine
@onready var sprite := $gizmo/sprite
@onready var runEffect := $gizmo/runEffect
@onready var camera := $Camera2D
@onready var animationTree := $AnimationTree
@onready var animationTreePlayback : AnimationNodeStateMachinePlayback = animationTree["parameters/playback"]
@onready var normalPlayback :  AnimationNodeStateMachinePlayback = animationTree["parameters/NORMAL/playback"]
@onready var runPlayback :  AnimationNodeStateMachinePlayback = animationTree["parameters/RUN/playback"]
@onready var coyoteTimer := $CoyoteTimer
@onready var jumpBufferTimer := $JumpBuffer
const runSpeed := 500

var shouldWalk := false
var jumpBuffer := false
var coyoteTime := false
var shouldRun := false
var running := false

func _ready() -> void:
	stateMachine.init("IDLE")

func move(delta, _run := false):
	var direction := Input.get_axis("ui_left", "ui_right")
	var speed := maxSpeed
	var force := 300.0
	if running or (shouldRun and is_on_floor()):
		speed = runSpeed
		force = 200
		
	if sign(velocity.x) != sign(direction):
		force *= 2.2
	velocity.x = move_toward(velocity.x, speed*direction, delta*force)

func shouldJump() -> bool:
	return jumpBuffer and (is_on_floor() or coyoteTime)

func rotateSprite(delta):
	if not spriteGizmo: return
	if abs(velocity.x) <= maxSpeed or is_on_floor():
		super(delta)
		return
		
	var weight := 10
	var angle : float = velocity.angle()
	if velocity.x < 0: angle += PI
	spriteGizmo.rotation = lerp_angle(spriteGizmo.rotation, angle, weight * delta)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("jump"):
		jumpBuffer = true
		jumpBufferTimer.start()
	
	shouldRun = Input.is_action_pressed("run")
	running = shouldRun and abs(velocity.x) >= runSpeed
	
	stateMachine.process(delta)
	gravity(delta)
	setupVisual(delta)
	
	var onFloor := is_on_floor()
	move_and_slide()
	if is_on_floor() == false and onFloor:
		coyoteTimer.start()
		coyoteTime = true
		
func setupVisual(delta):
	sprite.flip_h = shouldFlip(sprite.flip_h)
	runEffect.flip_h = sprite.flip_h
	runEffect.position.x = 12 - 24 * int(sprite.flip_h)
	var speed = abs(velocity.x)
	runEffect.visible = speed > maxSpeed
	runEffect.self_modulate.a = (speed - maxSpeed) / (runSpeed - maxSpeed) *0.7
	rotateSprite(delta)

func _on_coyote_timer_timeout() -> void:
	coyoteTime = false

func _on_jump_buffer_timeout() -> void:
	jumpBuffer = false
