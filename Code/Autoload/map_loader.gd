extends Node

var province_scene = preload("res://Scenes/province.tscn")
const exports_path = "Imports/"

func _ready():

	# deserialize resources
	var resources = _deserialize_resources( exports_path + "resourcesExported.json" )
	for r in resources:
		WorldState.RESOURCES[ r ] = { "demand": 0, "supply": 0 }
		
	# deserialize factories
	var factories = _deserialize_factories( exports_path + "factoriesExported.json" )
	print( "Printing factories..." )
	for f in factories:
		print(f)
		if f.input_resources and f.input_resources_amount:  # if not null
			if f.input_resources.size() != f.input_resources_amount.size():
				print( "## Factory input resources vs amount mismatch - skipping" )
				continue
		else:
			continue
		
		if f.output_resources and f.output_resources_amount:
			if f.output_resources.size() != f.output_resources_amount.size():
				print( "## Factory output resources vs amount mismatch - skipping" )
				continue
		else:
			continue
		
		var input_res = {}
		for i_res in f.input_resources.size():
			input_res[ f.input_resources[i_res].name ] = f.input_resources_amount[i_res]
		
		var output_res = {}
		for i_res in f.output_resources.size():
			output_res[ f.output_resources[i_res] ] = f.output_resources_amount[i_res]
		
		var factory = Factory.new( f.name, f.price, f.timeToProduce, input_res, output_res )
		WorldState.FACTORIES.append( factory )
	
	# deserialize countries
	var countries = _deserialize_countries( exports_path + "countriesExported.json" )
	for c in countries:
		WorldState.COUNTRIES.append( Country.new( c.name, c.capital, Color( c.color[0], c.color[1], c.color[2] ) ) )

	# deserialize provinces
	var data = _deserialize_provinces( exports_path + "provincesExported.json" )
	for i in data:
		### add provinces
		var province_instance = province_scene.instantiate()
		province_instance.setName( i.name )
		province_instance.shape = i.shape
		province_instance.country = i.country.name if i.country is Dictionary else "SEA"
		
		# if resources list size doesn't match resourcesAmounts list size then skip adding them to provinces
		if i.resourcesAmounts and ( i.resources.size() == i.resourcesAmounts.size() ):
			if not i.resources == []:
				var resources_str: Array[String]= []
				for r in i.resources:
					resources_str.append( r.name )
				province_instance.resources = resources_str
			else:
				# we may actually consider barran wastelands provinces that don't have any resources (?)
				province_instance.resources = [ "### NO RESOURCE - FIX IT ###" ]
			province_instance.resources_amount = i.resourcesAmounts if i.resourcesAmounts else []
		else:
			print( "### ERROR: size of resources list doesn't match size of resourceAmounts lists - they will be all empty" )
		
		province_instance.terrain = i.terrain.name if i.terrain else "### NO TERRAIN - FIX IT ###"
		
		# gather reosurces into global market supply
		# TODO: maybe first gather resources intro countries and then into global market
		# right now we are iterating over all provinces twice...
		if i.resourcesAmounts and ( i.resources.size() == i.resourcesAmounts.size() ):
			for r in i.resources.size():
				if WorldState.RESOURCES.has( i.resources[r].name ):
					WorldState.RESOURCES[ i.resources[r].name ].supply += i.resourcesAmounts[r]
		else:
			print( "### ERROR: size of resources list doesn't match size of resourceAmounts lists - Skipping resource addition to global market" )
			
		
		if i.color != null:
			if i.color.size() == 4:
				# case where we provided RGBA
				var color = Color( float(i.color[0])/255, float(i.color[1])/255, float(i.color[2])/255, 255 )
				province_instance.color = color
			if i.color.size() == 3:
				# case where we provided RGB only
				province_instance.setColor( Color( float(i.color[0])/255, i.color[1]/255, i.color[2]/255 ) )
		else:
			print( "### FIX IT ### {name} has no Color".format({ "name": i.name }) )
		add_child(province_instance)
		
		WorldState.PROVINCES.append( province_instance )
	
	_gather_pop_from_provinces_to_countries( data )
	_gather_production_from_provinces_to_countries( data )

func _deserialize_resources( file_path: String ):
	var resource_file = FileAccess.open( file_path, FileAccess.READ )
	var data = JSON.parse_string( resource_file.get_as_text() )
	resource_file.close()
	return data

func _deserialize_provinces(file_path: String):
	var prov_file = FileAccess.open(file_path, FileAccess.READ)
	var data = JSON.parse_string(prov_file.get_as_text())
	for i in data:
		var vector_as_string = i.shape
		vector_as_string = vector_as_string.substr(1, len(vector_as_string) - 2)
		var array_of_string_vec2s = vector_as_string.split("),")
		
		# convert stringified list of shape vectors to PackedList
		var shape = PackedVector2Array()
		for vec2_str in array_of_string_vec2s:
			vec2_str = vec2_str.replace(" (", "")
			vec2_str = vec2_str.replace("(", "")
			vec2_str = vec2_str.replace(",", "")
			vec2_str = vec2_str.split(" ")
			var vec2_int = Vector2( int(vec2_str[0]), int(vec2_str[1]) )
			shape.append(vec2_int)
		i.shape = shape
		
		# if Country is not assigned to Province (it's <null> instead e.g.: { 'name': 'Poland' }
		if not i.country is Dictionary:
			if i.terrain is Dictionary:			
				if i.terrain.name == "sea":
					pass
				else:
					print( "### FIX IT ### Province without Country: " + i.name )
					i.country = { 'name': "### MISSING COUNTRY ###" }
			else:
				print( "### FIX IT ### Province without Terrain: " + i.name )
			
		# if Resources are not assigned to Province then it's empty Array
		if i.resources == []:
			print( "### FIX IT ### Province without any Resource: " + i.name )
			#i.resources = [{ "name": "### MISSING RESOURCE ###" }]
		
		print( i.resourcesAmounts )
			
	prov_file.close()
	return data

func _deserialize_countries( file_path: String ):
	var country_file = FileAccess.open( file_path, FileAccess.READ )
	var data = JSON.parse_string(country_file.get_as_text())
	for i in data:
		pass
	country_file.close()
	return data
	
func _deserialize_factories( file_path: String ):
	var factories_file = FileAccess.open( file_path, FileAccess.READ )
	var data = JSON.parse_string( factories_file.get_as_text() )
	for i in data:
		pass
	factories_file.close()
	return data

func _gather_pop_from_provinces_to_countries( deserialized_provinces ):
	for p in deserialized_provinces:
		if not p.country is Dictionary:  # if it's Sea Province then Country is null
			continue
		for c in WorldState.COUNTRIES:
			if c._name == p.country.name:
				c._pop += p.pop
	for c in WorldState.COUNTRIES:
		print( "{c} has {p} population in total".format({'c': c._name, 'p': c._pop}) )

func _gather_production_from_provinces_to_countries( deserialized_provinces ):
	for p in deserialized_provinces:
		if not p.country is Dictionary:  # if it's Sea Province then Country is null
			continue
		for c in WorldState.COUNTRIES:
			if c._name == p.country.name:  # if province belongs to country
				if p.resourcesAmounts and ( p.resources.size() == p.resourcesAmounts.size() ):
					for r in p.resources.size():
						print(p.resources[r])
						if c._production.has( p.resources[r].name ):  # if resource alredy exist in country market
							c._production[ p.resources[r].name ] += p.resourcesAmounts[r]
						else:
							c._production[ p.resources[r].name ] = p.resourcesAmounts[r]
	for c in WorldState.COUNTRIES:
		print( "{c} has {r}".format( { "c":c._name, "r": c._production} ) )

func get_country_instance( country_name: String ):
	for c in WorldState.COUNTRIES:
		if country_name == c._name:
			# DOES IT MAKE A COPY OR RETURNS REFERENCE???
			# it seems it's reference to original one
			return c
