extends Node2D
@onready var player = $TileMap/player
@onready var heartsContainer = $CanvasLayer/heartsContainer
# Called when the node enters the scene tree for the first time.
func _ready():
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
