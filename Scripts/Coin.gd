# Allows for collisions but doesn't do anything with the actual collision
# Really for when you want objets to collide but not affect each other directly
extends Area2D

func _ready() -> void:
	
#	Allows the area to listen for when a body collides with it
	connect("body_entered", self, "onBodyEntered")
	
#	Tweens are able to smoothly change the value of a property 	automatically
#	Listens for when the tween's animation has finished and runs the 	startTween function 
	$Tween.connect("tween_all_completed", self, "startTween")
	startTween()

# A custom function that allows me to easily start the tween and update its animation
func startTween():
#	Updates the aniamtion for the tween
	$Tween.interpolate_property($Sprite, "scale:x", $Sprite.scale.x, abs($Sprite.scale.x - 1), 1, Tween.TRANS_LINEAR)
#	Plays the animation
	$Tween.start()

# A custom function connected to the body_entered event
# So it runs when a body enters the collider
func onBodyEntered(body: Node):
	
#	Check the object is the player
	if(body.name == "Player"):
		
#		Gets the coin manager and tells it a coin was collected
		get_node("/root/CoinManager").coinCollected()
#		Remove this object once it's finished processing
		queue_free()
