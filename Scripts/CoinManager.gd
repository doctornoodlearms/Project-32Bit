# A node is the base object for basically everything in Godot
extends Node

# Signals allow us to call functions without knowing the object or function that is being called
# So where running a function manually is like whispering to someone,
# you know exactly who your talking to and what they do, and if they respond
# Signals are more like a megaphone where you just announce something and someone might respond but you won't know
signal onCoinCollected

# Tracking coins collected
var coinCount = 0

# Function run by a coin to update the collected coins
func coinCollected():
	
#	Update coins variable
	coinCount += 1
#	Emit the singal telling anything listening a coin was collected
	emit_signal("onCoinCollected", coinCount)
