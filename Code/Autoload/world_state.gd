extends Node

var COUNTRIES = []
var PROVINCES = []
var player_country: Country   # country the player chose



func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func next_turn():
	print( "Next Turn starting..." )
	for p in PROVINCES:
		if p.getName() == "Lviv":
			p.setColor( Color( 0, 0, 50 ) )
	for c in COUNTRIES:
		pass
	print( "Next Turn finished" )
