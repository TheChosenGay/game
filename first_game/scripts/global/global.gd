extends Node

enum RoleState {
	Idle,
	Run,
	Attack,
	Jump,
	Freeze,
}

enum FaceDirection {
	Left,
	Right,
	Down,
	Up,
	force_move, #强制位移
}

enum ItemType {
	# 玩家
	Player,
	# Enemy
	Enemy,
	# 除了上述外，所有可被检测到的东西
	Item,
}

enum RelationshipType {
	Hostile, # 敌对
	Friendly, # 友好
	Neutral # 中立
}

func get_item_type_name(type: ItemType) -> String:
	match type:
		ItemType.Player:
			return "Player"
		ItemType.Enemy:
			return "Enemy"
		_:
			return "Item"
	


func get_vector_from(face_direction: FaceDirection) ->Vector2:
	match face_direction:
		FaceDirection.Left:
			return Vector2.LEFT
		FaceDirection.Right:
			return Vector2.RIGHT
		FaceDirection.Down:
			return Vector2.DOWN
		FaceDirection.Up:
			return Vector2.UP
		_:
			return Vector2.ZERO

func get_face_direction_from(vec: Vector2) -> FaceDirection:
	match vec:
		Vector2.LEFT: return FaceDirection.Left
		Vector2.RIGHT: return FaceDirection.Right
		Vector2.DOWN: return FaceDirection.Down
		_: return FaceDirection.Up

static var PLAYER_HIT_LAYER = 4
static var PLAYER_HURT_LAYER = 5
static var MONITOR_HIT_LAYER = 6
static var MONITOR_HURT_LAYER = 7
