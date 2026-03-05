extends Node

@onready var Money : int = 10

@export var Sell_stuff_image : Array[Texture2D] = []
@export var Sell_stuff_name : Array[String] = []
@export var Sell_price : Array[int] = [1,5,10,15,20,30,40,60,100,5]

@export var Minion_image : Array[Texture2D] = []
@export var Minion_upgrade : Array[int] = [5,25,50,60,100,150]
@export var Minion_increment : Array[int] = [5,25,50,60,100,150]
