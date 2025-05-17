# 游戏开发待办事项整理

1. 行为树
2. 程序生成地图的方案
3. 背包系统
4. 角色拾取 : 完成，collisionShape要设置disabled，不要设置不可见
5. 寻路系统： NavigationAgent
6. 伤害系统：visible 和 disabled ,注意分层
7. strategy pattern：模块化升级 , Resource in Godot
8. Resource 理解
9. 制作漂亮的UI控件

## 在Hitbox中添加打击停顿
func hit_stop():
    # 暂时降低游戏速度
    Engine.time_scale = 0.1
    # 短暂延迟后恢复
    await get_tree().create_timer(0.1 * 0.1).timeout
    Engine.time_scale = 1.0

## 在Hitbox中添加攻击轨迹
func create_slash_effect():
    var slash = preload("res://slash_effect.tscn").instantiate()
    slash.global_position = global_position
    get_tree().root.add_child(slash)

### Resource 使用方法

1.  方法1：通过代码创建

```GDScript
var player_data = PlayerData.new()
player_data.health = 150
player_data.speed = 400.0
```

2. 方法2：加载已保存的资源

```GDScript
var loaded_data = load("res://resources/player_data.tres")
```

3. 方法3：预加载资源（推荐用于频繁使用的资源）
```GDScript
@onready var preloaded_data = preload("res://resources/player_data.tres")
```


### 保存资源
```GDScript
extends Resource
class_name GameData

@export var score: int = 0
@export var player_position: Vector2

func save_to_file(path: String) -> void:
    var error = ResourceSaver.save(self, path)
    if error != OK:
        print("保存失败：", error)

加载资源
func load_from_file(path: String) -> Resource:
    if FileAccess.file_exists(path):
        return load(path)
    return null

```