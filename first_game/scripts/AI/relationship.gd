extends Node

class_name RelationshipEngine

var role_type: global.ItemType

# 后续可以考虑用关系表格的方式，缓存关系
func _init(type: global.ItemType) -> void:
	role_type = type

func get_relationship_of(type: global.ItemType) -> global.RelationshipType:
	match role_type:
		global.ItemType.Enemy:
			return self.get_relationship_of_enemy(type)
		_:
			return self.get_relationship_of_player(type)
		

func get_relationship_of_enemy(type: global.ItemType) -> global.RelationshipType:
	match type:
		global.ItemType.Enemy:
			return global.RelationshipType.Friendly
		global.ItemType.Player:
			return global.RelationshipType.Hostile
		_:
			return global.RelationshipType.Neutral
			
func get_relationship_of_player(type: global.ItemType) -> global.RelationshipType:
	match type:
		global.ItemType.Enemy:
			return global.RelationshipType.Hostile
		global.ItemType.Player:
			return global.RelationshipType.Hostile
		_:
			return global.RelationshipType.Neutral
