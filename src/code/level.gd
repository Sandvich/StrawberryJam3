extends Node

var songname
var difficulty
var artist
var bpm
var file
var precision
var code

func _init(levelName, levelDifficulty, levelArtist, levelBpm, levelFile, levelPrecision, levelCode):
	songname = str(levelName)
	difficulty = levelDifficulty
	artist = levelArtist
	bpm = float(levelBpm)
	file = levelFile
	precision = float(levelPrecision)
	code = levelCode
