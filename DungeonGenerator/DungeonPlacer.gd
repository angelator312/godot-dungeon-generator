class_name DungeonPlacer

var tilemap_walls: TileMapLayer
var tilemap_floor: TileMapLayer
var floor_index: Vector2i=Vector2i(0,0)
var wall_vector_up: Vector2i=Vector2i(0,1)
var wall_vector_right: Vector2i=Vector2i(2,3)
const SOURCE_ID_Floor=1
const SOURCE_ID_Walls=0
func _init(_tilemap_walls:TileMapLayer,_tilemap_floor:TileMapLayer):
	tilemap_walls = _tilemap_walls
	tilemap_floor = _tilemap_floor
	#floor_index = tilemap_walls.tile_set.find_tile_by_name("Floor")
	#wall_vector_up = tilemap_walls.tile_set.find_tile_by_name("Wall")

func place_dungeon(dungeon: DungeonData) -> void:
	for slot in dungeon.rooms:
		place_room(dungeon.rooms[slot])
		
	for slot in dungeon.tunnels:
		var tunnel = dungeon.tunnels[slot]
		var direction = slot[1] - slot[0]
		
		if direction in [Vector2.UP, Vector2.DOWN]:
			place_v_tunnel(tunnel)
		else:
			place_h_tunnel(tunnel)

func place_room(rect: Rect2) -> void:
	place_floor(rect)
	place_h_walls(rect)
	place_v_walls(rect)

func place_h_tunnel(rect: Rect2) -> void:
	place_floor(rect)
	place_h_walls(rect)
	for y in range(rect.position.y+1,rect.end.y):
		# Left walls cleaned
		tilemap_walls.set_cell(Vector2i(rect.position.x,y))
		# Right walls cleaned
		tilemap_walls.set_cell(Vector2i(rect.end.x,y))

func place_v_tunnel(rect: Rect2) -> void:
	place_floor(rect)
	place_v_walls(rect)

func place_floor(rect: Rect2) -> void:
	for x in range(rect.position.x, rect.end.x + 1):
		for y in range(rect.position.y, rect.end.y + 1):
			tilemap_floor.set_cell(Vector2i(x, y),SOURCE_ID_Floor, floor_index)

func place_h_walls(rect: Rect2) -> void:
	for x in range(rect.position.x, rect.end.x + 1):
		# The up walls
		var pos:=Vector2i(x, rect.position.y)
		tilemap_walls.set_cell(pos,SOURCE_ID_Walls, wall_vector_right)
		# The down walls
		pos=Vector2i(x, rect.end.y)
		tilemap_walls.set_cell(pos,SOURCE_ID_Walls, wall_vector_right)

func place_v_walls(rect: Rect2) -> void:
	for y in range(rect.position.y, rect.end.y + 1):
		# The left walls
		var pos=Vector2i(rect.position.x, y)
		tilemap_walls.set_cell(pos,SOURCE_ID_Walls, wall_vector_up)
		# The right walls
		pos=Vector2i(rect.end.x, y)
		tilemap_walls.set_cell(pos, SOURCE_ID_Walls,wall_vector_up)
