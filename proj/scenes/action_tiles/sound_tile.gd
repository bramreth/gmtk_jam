extends "res://scenes/action_tiles/action_tile.gd"

enum Note {
	ZERO = 0,
	ONE = 1,
	TWO = 2,
	THREE = 3,
	FOUR = 4,
	FIVE = 5,
	SIX = 6,
	SEVEN = 7,
	EIGHT = 8,
	NINE = 9,
	TEN = 10,
	ELEVEN = 11
}

export (Note) var note = Note.ZERO

func _on_player_entered(player):
	_play_sound("notes/note" + str(note) + ".wav")
