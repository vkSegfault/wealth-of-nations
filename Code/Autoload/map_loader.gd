extends Node

var countries_JSON = {
	"Poland": { "capital": "Warsaw", "color": Color(1, 0, 0) },
	"Germany":{ "capital": "Berlin", "color": Color(0, 1, 0) }
}

var countries_INTERNAL = []

var province_scene = preload("res://Scenes/province.tscn")
var provinces_JSON = {
	"Pomerania": { "country": "Poland", "pop": 3_000_000 },
	"Mecklenburg–WestPomerania":{ "country": "Germany", "pop": 2_000_000 }
}

var provinces_INTERNAL = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# serialize countries
	for country in countries_JSON:
		#print(country)
#		print(countries_JSON[country]) # print key
#		print(countries_JSON[country]["capital"]) # print value
#		print(countries_JSON[country]["color"]) # print value
		countries_INTERNAL.append( Country.new( country, countries_JSON[country]["capital"], countries_JSON[country]["color"] ) )
	print("We serialized {c} countries".format({"c": countries_INTERNAL.size() }))
	
	# serialize provinces
	for province in provinces_JSON:
		#print(province)
		#provinces_INTERNAL.append( Province.new( provinces_JSON[province]["country"], provinces_JSON[province]["pop"] ) )
		pass
	print("We serialized {p} provinces".format({"p": provinces_INTERNAL.size() }))
	
	# iterate over all drew in editor provinces and make actual logical Province out of vertices
	for i in get_node("/root/Root/WorldDrawDebug/Node2D").get_children():
		
		# if it's not Polygon2D then it's some debug temp shit probablu and we don't care
		if not (i is Polygon2D):
			continue
			
		#print("Province: {p} with coords: {c}".format({"p": i.name, "c": i.polygon}))
		
		var province_instance = province_scene.instantiate()
		province_instance.province_name = i.name
		province_instance.shape = i.polygon
		# this if check ensures that name from godot internal provinces matches ones from external DB
		# THERE SHOULD NEVER BE else PATH EXECUTED! if so fix the data (probablu Province name mismatch)
		# i.name - name of Province from internal Godot map
		# provinces_JSON.keys() - name of Province from dict DB
		if i.name in provinces_JSON.keys():
			print("Province: {p} is in province dictionary".format({"p": i.name}))
			var country = provinces_JSON[i.name]["country"]
			province_instance.country = country
			var country_color = countries_JSON[country]["color"]
			province_instance.color = country_color
			var pop = provinces_JSON[i.name]["pop"]
			province_instance.pop = pop
		else:
			print("###FIX IT ### Province: {p} is NOT in province dictionary".format({"p": i.name}))

		add_child(province_instance)
	
	
	# iterare provinces and add to country it belongs to
	# for prov in provinces_INTERNAL:
	#	#
	# 	prov.color = countries_JSON[ province_INTERNAL[prov][country] <- this give us country name ][color]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
