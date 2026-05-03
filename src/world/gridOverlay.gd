extends Node2D

@export var tilemap: TileMapLayer
@export var grid_range := 20

func _draw():
	if tilemap == null:
		return

	var tile_size = tilemap.tile_set.tile_size

	for x in range(-grid_range, grid_range):
		for y in range(-grid_range, grid_range):
			var cell = Vector2i(x, y)

			# conversion isométrique correcte
			var world_pos = tilemap.map_to_local(cell)

			# dessiner un losange iso (pas un carré)
			draw_iso_cell(world_pos, tile_size)
			
func draw_iso_cell(pos: Vector2, size: Vector2):
	var w = size.x / 2
	var h = size.y / 2

	var points = [
		pos + Vector2(0, -h),
		pos + Vector2(w, 0),
		pos + Vector2(0, h),
		pos + Vector2(-w, 0)
	]

	for i in range(points.size()):
		draw_line(points[i], points[(i + 1) % points.size()], Color(1, 1, 1, 0.2), 1)
