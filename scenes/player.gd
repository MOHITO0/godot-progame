extends CharacterBody2D

@export var speed: int = 100
@onready var animations = $AnimationPlayer
@export var maxHealth = 3
signal healthChanged
@onready var hurtBox = $hurtBox


var isHurt: bool = false

var currentHealth: int = 3
func getInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed
	

func updateAnimation():
	if velocity.length() == 0:
		animations.stop()
	else: 
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		animations.play("walk" + direction)

func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		

func _physics_process(delta):
	getInput()
	move_and_slide()
	handleCollision()
	updateAnimation()
	if !isHurt:
		for area in hurtBox.get_overlapping_areas():
			if area.name == 'hitBox':
				hurtByEnemy(area)



func _on_hurt_box_area_entered(area):
	if area.name == "hitBox":
		currentHealth -= 1
		if currentHealth < 0:
			currentHealth = maxHealth
		
		healthChanged.emit(currentHealth)

		knockback()

func hurtByEnemy(area):
	currentHealth -= 1
	if currentHealth < 0:
		currentHealth = maxHealth
	healthChanged.emit(currentHealth)
	isHurt = true

func knockback():
	var knockbackDirection = -velocity
	velocity = knockbackDirection
	move_and_slide()
