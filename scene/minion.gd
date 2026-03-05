extends Control
class_name Minion

@export var level := 0
@export var upgrade_cost : int
@export var upgrade_increment : int
@export var image_insert : Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Image.texture = image_insert
	$Image.scale = Vector2(0.2,0.2)
	$Image/Rate.text = "Rate: " + str(level) + " / 5s"
	$Image/Upgrade.text = "Upgrade: " + str(upgrade_cost)

func produce() -> int:
	return level
	

func _on_upgrade_pressed() -> void:
	if Global.Money >= upgrade_cost:
		Global.Money -= upgrade_cost
		level += 1
		upgrade_cost += upgrade_increment
		$Image/Rate.text = "Rate: " + str(level) + " / 5s"
		$Image/Upgrade.text = "Upgrade: " + str(upgrade_cost)
	
