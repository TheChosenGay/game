extends Node

enum RoleState {
	Idle,
	Run,
	Attack,
	Jump,
}

enum FaceDirection {
	Left,
	Right,
	Down,
	Up
}

static var PLAYER_HIT_LAYER = 4
static var PLAYER_HURT_LAYER = 5
static var MONITOR_HIT_LAYER = 6
static var MONITOR_HURT_LAYER = 7
