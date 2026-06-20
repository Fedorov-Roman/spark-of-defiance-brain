@tool
extends EditorScript

func _run() -> void:
	var dir := "res://assets/art/placeholder/"
	if not DirAccess.dir_exists_absolute(dir):
		DirAccess.make_dir_recursive_absolute(dir)

	_create_image(dir + "player.png", 32, 32, Color.GREEN)
	_create_image(dir + "enemy.png", 32, 32, Color.RED)
	_create_image(dir + "npc.png", 32, 32, Color.BLUE)
	_create_image(dir + "wall.png", 32, 32, Color.GRAY)
	_create_image(dir + "ground.png", 32, 32, Color.BROWN)
	_create_image(dir + "collectible.png", 32, 32, Color.GOLD)
	_create_image(dir + "ui_panel.png", 64, 64, Color(0.2, 0.2, 0.2))
	_create_image(dir + "transition.png", 640, 360, Color.BLACK)
	_create_image(dir + "boss.png", 48, 48, Color.PURPLE)
	_create_image(dir + "icon.png", 128, 128, Color.GREEN)
	print("Placeholder images generated.")

func _create_image(path: String, width: int, height: int, color: Color) -> void:
	var img := Image.create(width, height, false, Image.FORMAT_RGBA8)
	img.fill(color)
	img.save_png(path)
