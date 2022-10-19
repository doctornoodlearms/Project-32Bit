# Bodys allow for collision and will also dictate how other bodies move when colliding
# A kinematic body specifically is mainly used for player objects since they don't move normally
extends KinematicBody2D

#Gravity varaible
const gravity:int = 10

# Controls the horizontal direction and speed
var direction = 0
var speed = 300

# The export keyword lets Godot expose the varaible into the editor allowing it to be changed outside of a script
# A curve texture is just a type of texture used for curves, here it's being used to track how effective the players jump should be over time
export var jumpCurve:CurveTexture
var jumpInput = false
var isJumping = false
var jumpTime = 0
var jumpTimeMax = 2
var jumpStrength = 500

var velocity = Vector2(0,0)

# This runs every physics tick and is independant of the frame rate, as a result it exposes delta which can be used to sync physics stuff with the framerate
func _physics_process(delta: float) -> void:
	
#	Update the players velocity for gravity
	velocity.y += gravity
	
#	Prevent the player's velocity from scaling endlessly while on the 	ground
	if(is_on_floor()):
		velocity.y = 0
	
#	Update the players velocity for walking
	velocity.x = direction * speed
	
#	Update whether the player is able to jump at the moment
	isJumping = is_on_floor() and jumpInput
	
#	Jump physics
	if(isJumping):
#		Gets the point on the jump curve based on how long the player has 		been jumping for
		velocity.y = jumpCurve.curve.interpolate(jumpTime / jumpTimeMax) * jumpStrength * -1
#		Update how long the player has been jumping for
#		Delta is being used here to account for variation between frame 		rates, but we are able to know how much time has passed because 		delta is determined by the frame rate. So once it has fully 		incremented a second has passed
#		Its weird 
		jumpTime += delta
	
#	End the jump if the max time has been reached
	if(jumpTime >= jumpTimeMax):
		isJumping = false
	
#	Moves the player, this smoothly moves the player by the velocity while 	also accounting for any collisions. (It also requires the up direction 	which is used to check whats a floor and such)
	move_and_slide(velocity, Vector2.UP)

# This is a built in function that runs when ever there is an input of any kind
func _input(event: InputEvent) -> void:
	
#	Check if the given input was a key
	if(event.get_class() == "InputEventKey"):
		
#		Update the players horizontal direction
#		Also move_right and move_left are input actions that have been 		defined in the project settings. This allows us to use a single 		function to check if different inputs are being pressed. For example 		left on a keyboard but it can also account for a controller 
		direction = (Input.is_action_pressed("move_right") as int) - (Input.is_action_pressed("move_left") as int)
#		Updates if the player is holding jump
		jumpInput = Input.is_action_pressed("move_jump")
		
