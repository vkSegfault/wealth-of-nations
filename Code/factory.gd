extends Node
class_name Factory

var _factory_name: String
var _price: int
var _time_to_produce: int  # in weeks
var _resources_input = {}  # e.g.: { fish: 2, cars: 12 }
var _resources_output = {}

func _init( factory_name: String, price: int, time_to_produce: int, resources_input, resouces_output ):
	_factory_name = factory_name
	_price = price
	_time_to_produce = time_to_produce
	_resources_input = resources_input
	_resources_output = resouces_output
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


@warning_ignore("unused_parameter")
func _process(delta):
	pass
