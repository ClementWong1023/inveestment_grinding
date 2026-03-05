extends Control
class_name Sell_Stuff

@export var sell_card : PackedScene
@export var minion : PackedScene
@export var first_row : HBoxContainer
@export var second_row : HBoxContainer
@export var minion_store : VBoxContainer

var scene_stored : Array[Control]
var minion_stored : Array[Control]
var stonks_change := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	$Display_money.text = "Money: " + str(Global.Money)
	for i in range(0,5): #1st row items
		var sell_card_instance = sell_card.instantiate()
		sell_card_instance.price_insert = Global.Sell_price[i]
		sell_card_instance.image_insert = Global.Sell_stuff_image[i]
		sell_card_instance.name_insert = Global.Sell_stuff_name[i]
		scene_stored.push_back(sell_card_instance)
		first_row.add_child(sell_card_instance)
	for i in range(5,10): #2nd row items
		var sell_card_instance = sell_card.instantiate()
		sell_card_instance.price_insert = Global.Sell_price[i]
		sell_card_instance.image_insert = Global.Sell_stuff_image[i]
		sell_card_instance.name_insert = Global.Sell_stuff_name[i]
		scene_stored.push_back(sell_card_instance)
		second_row.add_child(sell_card_instance)
	for i in range(0,6):
		var minion_instance = minion.instantiate()
		if i == 0:
			minion_instance.level = 1
		else:
			minion_instance.level = 0
		minion_instance.upgrade_cost = Global.Minion_upgrade[i]
		minion_instance.upgrade_increment = Global.Minion_increment[i]
		minion_instance.image_insert = Global.Minion_image[i]
		minion_stored.push_back(minion_instance)
		minion_store.add_child(minion_instance)

func _on_chagne_price_timeout() -> void:
	Global.Sell_price[0] = randi_range(0,2) #Plank
	Global.Sell_price[1] = randi_range(4,12) #Coppper
	Global.Sell_price[2] = randi_range(5,25) #Iron
	Global.Sell_price[3] = randi_range(2,5) * randi_range(3,6) # Gold
	Global.Sell_price[4] = (int)(randfn(30,12)) #Diamond
	Global.Sell_price[5] = (int)(max(10,pow(randfn(0,8),2))) #Emerald
	Global.Sell_price[6] = (int)(sqrt(randi_range(1,10000))) #Eye
	var dfrag = randi_range(20,90)
	Global.Sell_price[7] = (int)(dfrag * log(dfrag)) #DFrag
	Global.Sell_price[8] = (int)(max(30,pow(randfn(20,10),1.6))) #Cookie
	stonks_change += randi_range(1,10) #Stonks
	if (stonks_change >= 14) and (Global.Sell_price[9] > Global.Money * 2):
		Global.Sell_price[9] = max(10, sqrt(Global.Sell_price[9]))
		stonks_change -= 14
	elif (stonks_change >= 10):
		Global.Sell_price[9] = randi_range(1,10*Global.Sell_price[9])
		stonks_change -= 10
	elif (stonks_change >= 5):
		Global.Sell_price[9] = randi_range(1,2*Global.Sell_price[9])
		stonks_change -= 5
		
	for i in range(0,10):
		if Global.Sell_price[i] <= 0:
			Global.Sell_price[i] = 1
		var minion_update := 0
		if i <= 5:
			minion_update = minion_stored[i].produce()
		scene_stored[i].update(minion_update,Global.Sell_price[i])

func _process(_delta: float) -> void:
	$Display_money.text = "Money: " + str(Global.Money)
	if Global.Money >= 5000000:
		get_tree().change_scene_to_file("res://scene/victory.tscn")
		
