extends Node

var COUNTRIES = []
var PROVINCES = []
var RESOURCES = {}
var player_country: Country   # country the player chose

var WEEK: int = 1
var YEAR: int = 2020

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func next_turn():
	print( "Next Turn starting..." )
	
	_update_week_info()
	
	
	print( "Updating Provinces..." )
	for p in PROVINCES:
		if p.getName() == "Lviv":
			p.setColor( Color( 0, 0, 50 ) )
			
	print( "Updating Countries..." )
	for c in COUNTRIES:
		for p in PROVINCES:
			if c._name == p.country:
				#print( "Updating " + p.getName() + " of " + c._name )
				for i in p.resources.size():
					#print( p.getName() + " is producing " + str(p.resources_amount[i]) + " " + str(p.resources[i]) )
					c._production[p.resources[i]] += p.resources_amount[i]
		print( c._production )
	
	print( "Next Turn finished" )

func _update_week_info():
	if WEEK == 52:
		WEEK = 1
		YEAR += 1
		return
	WEEK += 1
