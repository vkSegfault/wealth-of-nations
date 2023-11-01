extends Node

var COUNTRIES = []
var PROVINCES = []
var RESOURCES = {}
var PLAYER_COUNTRY: Country   # country the player choose

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
		# gather resources into world market from every province
		for i in p.resources.size():
			# if resource is in list of resource that should be accumulated
			if PLAYER_COUNTRY._resources_to_stock.has( p.resources[i] ):
				if PLAYER_COUNTRY._stock.has( p.resources[i] ):
					PLAYER_COUNTRY._stock[p.resources[i]] += p.resources_amount[i]
				else:
					PLAYER_COUNTRY._stock[p.resources[i]] = p.resources_amount[i]
			else:
				# if not provide it on the global market as usual
				RESOURCES[p.resources[i]]["supply"] += p.resources_amount[i]
			
			
	print( "Updating Countries..." )
	for c in COUNTRIES:
		for p in PROVINCES:
			if c._name == p.country:
				#print( "Updating " + p.getName() + " of " + c._name )
				for i in p.resources.size():
					#print( p.getName() + " is producing " + str(p.resources_amount[i]) + " " + str(p.resources[i]) )
					c._production[p.resources[i]] += p.resources_amount[i]
		print( c._name + " produces " + str(c._production) )
	
	SignalRelay._next_turn()
	
	print( "Accumulating resources: " + str( PLAYER_COUNTRY._resources_to_stock ) )
	
	print( "Next Turn finished" )

func _update_week_info():
	if WEEK == 52:
		WEEK = 1
		YEAR += 1
		return
	WEEK += 1
