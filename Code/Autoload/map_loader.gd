extends Node

var countries_JSON = {
	"Poland": { "capital": "Warsaw", "color": Color(1, 0, 0) },
	"Germany":{ "capital": "Berlin", "color": Color(0, 1, 0) }
}

var countries_INTERNAL = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# serialize countries
	for country in countries_JSON:
		print(country)
#		print(countries_JSON[country]) # print key
#		print(countries_JSON[country]["capital"]) # print value
#		print(countries_JSON[country]["color"]) # print value
		countries_INTERNAL.append( Country.new( country, countries_JSON[country]["capital"], countries_JSON[country]["color"] ) )
	print("We serialized {c} countries".format({"c": countries_INTERNAL.size() }))
	
	# serialize provinces
	
	# iterare provinces and add to country it belongs to
	# for prov in provinces_INTERNAL:
	#	#
	# 	prov.color = countries_JSON[ province_INTERNAL[prov][country] <- this give us country name ][color]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
