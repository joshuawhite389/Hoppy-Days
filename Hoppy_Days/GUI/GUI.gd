extends CanvasLayer

func _ready():
	$Control/TextureRect/HBoxContainer/LifeCount.text = "3"


func update_lives(lives_left, coins):
	$Control/TextureRect/HBoxContainer/LifeCount.text = str(lives_left)
	$Control/TextureRect/HBoxContainer/CoinCount.text = str(coins)
