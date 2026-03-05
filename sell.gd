extends Control
class_name Sell

@export var image_insert: Texture2D
@export var name_insert: String
@export var price_insert: int
@export var amount_insert: int = 0

@onready var Item_Image := $Image
@onready var Buy_Area := $Image/Buy
@onready var Sell_Area := $Image/Sell

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Item_Image.texture = image_insert
	$Image/Name.text = name_insert
	$Image/Amount.text = str(amount_insert)
	$Image/Price.text = "$ " + str(price_insert)
	Item_Image.scale = Vector2(1.0/3, 1.0/3)

func update(amount_changed: int, price_changed: int) -> void:
	$Image/Amount.text = str(amount_insert + amount_changed)
	price_insert = price_changed
	$Image/Price.text = "$ " + str(price_insert)

func _on_buy_pressed() -> void:
	if Global.Money >= price_insert:
		Global.Money -= price_insert
		amount_insert += 1
		update(0,price_insert)
		

func _on_sell_pressed() -> void:
	if amount_insert > 0:
		amount_insert -= 1
		update(0,price_insert)
		Global.Money += price_insert
