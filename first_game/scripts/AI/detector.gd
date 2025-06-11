extends Node2D
class_name Detector

@export var detect_radius:float = 100
@onready var detect_area: Area2D = $Area2D
@onready var detect_shape: CollisionShape2D = $Area2D/CollisionShape2D
# 信号
signal _item_entered(player:Node2D)



# 所有在范围内的物体
var items_in_range = {}


func _ready() -> void:
	detect_area.connect("body_entered", _on_body_entered)
	detect_area.connect("body_exited", _on_body_exited)
	
	# 设置检测范围
	detect_shape.radius = detect_radius
	self.add_child(detect_area)
	
	
# MARK: -- public

func get_items_with_type(type: global.ItemType) -> Array[Node2D]:
	var type_name = global.get_item_type_name(type)
	return items_in_range[type_name]

# MARK: -- private

func get_body_type_name(body: Node2D) -> String:
	var type_name
	if body.has("type"):
		type_name = global.get_item_type_name(body.type)
	else:
		type_name = "Item"
	return type_name

func _on_body_entered(body: Node2D):
	var type_name = self.get_body_type_name(body)
	if type_name in items_in_range:
		items_in_range[type_name].append(body)
	else:
		items_in_range[type_name] = [body]
		
	_item_entered.emit(body)


func _on_body_exited(body: Node2D):
	var type_name = self.get_body_type_name(body)
	if type_name in items_in_range:
		if body in items_in_range[type_name]:
			items_in_range[type_name].erase(body) 
