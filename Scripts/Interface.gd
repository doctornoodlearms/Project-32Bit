# Control nodes are just UI's
extends Control

func _ready() -> void:
	
#	Listens for when the coin manager announces a coin was collected
	get_node("/root/CoinManager").connect("onCoinCollected", self, "onCoinCollected")

# The function taht runs when a coin is colected
func onCoinCollected(value:int):
	
#	Update the UI's text
	$CointCount/Value.text = str(value)
