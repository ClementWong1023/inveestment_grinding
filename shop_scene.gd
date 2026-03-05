extends Control
class_name Sell_Stuff

@export var sell_card : PackedScene
@export var first_row : HBoxContainer
@export var second_row : HBoxContainer

var scene_stored : Array[Control]
var stonks_change := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	$Display_money.text = "Money: " + str(Global.Money)
	for i in range(0,5):
		var sell_card_instance = sell_card.instantiate()
		sell_card_instance.price_insert = Global.Sell_price[i]
		sell_card_instance.image_insert = Global.Sell_stuff_image[i]
		sell_card_instance.name_insert = Global.Sell_stuff_name[i]
		scene_stored.push_back(sell_card_instance)
		first_row.add_child(sell_card_instance)
	for i in range(5,10):
		var sell_card_instance = sell_card.instantiate()
		sell_card_instance.price_insert = Global.Sell_price[i]
		sell_card_instance.image_insert = Global.Sell_stuff_image[i]
		sell_card_instance.name_insert = Global.Sell_stuff_name[i]
		scene_stored.push_back(sell_card_instance)
		second_row.add_child(sell_card_instance)
		

func _on_chagne_price_timeout() -> void:
	Global.Sell_price[0] = randi_range(1,5) #Plank
	Global.Sell_price[1] = randi_range(2,15) #Coppper
	Global.Sell_price[2] = randi() % 20 #Iron
	Global.Sell_price[3] = randi_range(2,5) * randi_range(3,5) # Gold
	Global.Sell_price[4] = (int)(randfn(30,20)) #Diamond
	Global.Sell_price[5] = (int)(min(10,pow(randfn(0,10),2))) #Emerald
	Global.Sell_price[6] = (int)(sqrt(randi_range(1,10000))) #Eye
	Global.Sell_price[7] = (int)(Global.Sell_price[7] * log(Global.Sell_price[7]) / 2) #DFrag
	Global.Sell_price[8] = (int)(min(100,pow(randfn(20,10),1.6))) #Cookie
	stonks_change += randi_range(1,5) #Stonks
	if (stonks_change >= 10):
		Global.Sell_price[9] += randi_range(1,Global.Sell_price[9])
		stonks_change -= 10
		var chance := randi_range(1,10)
		if chance <= 1 and (Global.Sell_price[9] > Global.Money * 2):
			Global.Sell_price[9] = max(10, sqrt(Global.Sell_price[9]))

	for i in range(0,10):
		if Global.Sell_price[i] <= 0:
			Global.Sell_price[i] = 1
		scene_stored[i].update(0,Global.Sell_price[i])
		
func _process(_delta: float) -> void:
	$Display_money.text = "Money: " + str(Global.Money)
	if Global.Money >= 10000:
		get_tree().change_scene_to_file("res://victory.tscn")
		
