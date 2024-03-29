extends Node

var practice
var lights_off
var level
var precision = 1
var levels = []
var levelClass

func get_level(num):
	return levels[num]

func _ready():
	practice = true
	lights_off = false
	levelClass = load("res://code/level.gd")

	# Make our levels
	levels.append(levelClass.new("Slippery When Wet", "Medium", "fluffy", 140, "res://assets/ttio_1.wav", 1,
		[
			[2,		"left_deck_left",		2],
			[4,		"left_deck_up",			2],
			[6,		"left_deck_left",		2],
			[8,		"left_deck_right",		2],
			[10,	"left_deck_left",		2],
			[12,	"left_deck_up",			2],
			[14,	"left_deck_left",		2],
			[16,	"left_deck_right",		2],
			[18,	"left_deck_left",		2],
			[20,	"left_deck_up",			2],
			[22,	"left_deck_left",		2],
			[24,	"left_deck_right",		2],
			[26,	"left_deck_left",		2],
			[28,	"left_deck_up",			2],

		# Changing from chill opening to fast continuation
			[31,	"right_deck_up",		1],
			[32,	"right_deck_down",		1],
			[33,	"right_deck_up",		1],
			[34,	"right_deck_down",		1],
			[35,	"right_deck_up",		1],
			[36,	"right_deck_down",		1],
			[37,	"right_deck_up",		1],
			[38,	"right_deck_down",		1],
			[39,	"right_deck_up",		1],
			[40,	"right_deck_down",		1],
			[41,	"right_deck_up",		1],
			[42,	"right_deck_down",		1],
			[43,	"right_deck_up",		1],
			[44,	"right_deck_down",		1],
			[45,	"right_deck_up",		1],
			[46,	"right_deck_down",		1],
			[47,	"right_deck_up",		1],
			[48,	"right_deck_down",		1],
			[49,	"right_deck_up",		1],
			[50,	"right_deck_down",		1],
			[51,	"right_deck_up",		1],
			[52,	"right_deck_down",		1],
			[53,	"right_deck_up",		1],
			[54,	"right_deck_down",		1],
			[55,	"right_deck_up",		1],
			[56,	"right_deck_down",		1],
			[57,	"right_deck_up",		1],
			[58,	"right_deck_down",		1],
			[59,	"right_deck_up",		1],
			[60,	"right_deck_down",		1],
			[61,	"right_deck_up",		1],
			[62,	"right_deck_down",		1],

		# New vocal line comes in
			[62,	"left_deck_left", 		2],
			[63,	"left_deck_up",			2],
			[64,	"right_deck_left",		2],
			[65,	"right_deck_right",		2],
			[66,	"left_deck_left", 		2],
			[67,	"left_deck_up",			2],
			[68,	"right_deck_up",		2],
			[69,	"right_deck_right",		2],
			[70,	"left_deck_left", 		2],
			[71,	"left_deck_up",			2],
			[72,	"right_deck_left",		2],
			[73,	"right_deck_right",		2],
			[74,	"left_deck_left", 		2],
			[75,	"left_deck_up",			2],
			[76,	"right_deck_up",		2],
			[77,	"right_deck_right",		2],

		# A bit of variety in the vocal line
			[78,	"right_analog_rotate",	8],
			[78,	"left_deck_left", 		2],
			[79,	"left_deck_up",			2],
			[80,	"left_deck_right",		2],
			[81,	"left_deck_down",		2],
			[82,	"left_deck_left", 		2],
			[83,	"left_deck_up",			2],
			[84,	"left_deck_right",		2],
			[85,	"left_deck_down",		2],
			[86,	"left_analog_rotate",	8],
			[86,	"right_deck_left",		2],
			[87,	"right_deck_up",		2],
			[88,	"right_deck_right",		2],
			[89,	"right_deck_down",		2],
			[90,	"right_deck_left", 		2],
			[91,	"right_deck_up",		2],
			[92,	"right_deck_right",		2],
			[93,	"right_deck_down",		2],

		# Back to normal
			[98,	"left_deck_left", 		2],
			[99,	"left_deck_up",			2],
			[100,	"right_deck_up",		2],
			[101,	"right_deck_right",		2],
			[102,	"left_deck_left",		2],
			[103,	"left_deck_up",			2],
			[104,	"right_deck_left",		2],
			[105,	"right_deck_right",		2],
			[106,	"left_deck_left",		2],
			[107,	"left_deck_up",			2],
			[108,	"right_deck_up",		2],
			[109,	"right_deck_right",		2],
			[110,	"left_deck_left",		2],
			[111,	"left_deck_up",			2],
			[112,	"right_deck_left",		2],
			[113,	"right_deck_right",		2],
			[114,	"left_deck_left",		2],
			[115,	"left_deck_up",			2],
			[116,	"right_deck_up",		2],
			[117,	"right_deck_right",		2],
			[118,	"left_deck_left",		2],
			[119,	"left_deck_up",			2],
			[120,	"right_deck_left",		2],
			[121,	"right_deck_right",		2],
			[122,	"left_deck_left",		2],
			[123,	"left_deck_up",			2],
			[124,	"right_deck_up",		2],
			[125,	"right_deck_right",		2],

		# That weird woo-eee bit
			[126,	"left_deck_down",		2],
			[129,	"right_analog_rotate",	7],
			[134,	"left_deck_down",		2],
			[137,	"right_analog_rotate",	7],
			[142,	"left_deck_down",		2],
			[145,	"right_analog_rotate",	7],
			[150,	"left_deck_down",		2],
			[153,	"right_analog_rotate",	7],

		# Break up the woo-ees with the main vocal line again
			[158,	"left_deck_left",		2],
			[159,	"left_deck_up",			2],
			[160,	"right_deck_left",		2],
			[161,	"right_deck_right",		2],
			[162,	"left_deck_left",		2],
			[163,	"left_deck_up",			2],
			[164,	"right_deck_up",		2],
			[165,	"right_deck_right",		2],
			[166,	"left_deck_down",		2],
			[169,	"right_analog_rotate",	7],
			[174,	"left_deck_left",		2],
			[175,	"left_deck_up",			2],
			[176,	"right_deck_left",		2],
			[177,	"right_deck_right",		2],
			[178,	"left_deck_left",		2],
			[179,	"left_deck_up",			2],
			[180,	"right_deck_up",		2],
			[181,	"right_deck_right",		2],
			[182,	"left_deck_down",		2],
			[185,	"right_analog_rotate",	7],

		# woo-ee starts changing pitch
			[190,	"left_deck_down",		2],
			[193,	"right_analog_rotate",	7],
			[198,	"right_deck_up",		2],
			[201,	"left_analog_rotate",	7],
			[206,	"left_deck_down",		2],
			[209,	"right_analog_rotate",	7],
			[214,	"right_deck_up",		2],
			[217,	"left_analog_rotate",	7],

			[224,	"right_deck_right",		2],
			[225,	"right_deck_left",		2],
			[226,	"left_deck_left",		2],
			[227,	"left_deck_up",			2],
			[228,	"right_deck_up",		2],
			[229,	"right_deck_left",		2],
			[230,	"left_deck_left",		2],
			[231,	"left_deck_up",			2],
			[232,	"right_deck_right",		2],
			[233,	"right_deck_left",		2],
			[234,	"left_deck_left",		2],
			[235,	"left_deck_up",			2],
			[236,	"right_deck_up",		2],
			[237,	"right_deck_left",		2],

			[238,	"left_deck_left",		2],
			[239,	"left_deck_up",			2],
			[240,	"right_deck_right",		2],
			[241,	"right_deck_left",		2],
			[242,	"left_deck_left",		2],
			[243,	"left_deck_up",			2],
			[244,	"right_deck_up",		2],
			[245,	"right_deck_left",		2],
			[246,	"left_deck_left",		2],
			[247,	"left_deck_up",			2],
			[248,	"right_deck_right",		2],
			[249,	"right_deck_left",		2],
			[250,	"left_deck_left",		2],
			[251,	"left_deck_up",			2],
			[252,	"right_deck_up",		2],
			[253,	"right_deck_left",		2],

		# Fading out
			[254,	"left_deck_down",		2],
			[257,	"right_analog_rotate",	7],
			[262,	"left_deck_down",		2],
			[265,	"right_analog_rotate",	7],
			[270,	"left_deck_down",		2],
			[273,	"right_analog_rotate",	7],
			[278,	"left_deck_down",		2],
			[281,	"right_analog_rotate",	15]
		])
	)

	levels.append(levelClass.new("Slippery When Wet INCOMPLETE", "Hard", "fluffy", 140, "res://assets/ttio_1.wav", 1,
		[
			[2,		"left_deck_left",		2],
			[4,		"left_deck_up",			2],
			[6,		"left_deck_left",		2],
			[8,		"left_deck_right",		2],
			[10,	"left_deck_left",		2],
			[12,	"left_deck_up",			2],
			[14,	"left_deck_left",		2],
			[16,	"left_deck_right",		2],
			[18,	"left_deck_left",		2],
			[20,	"left_deck_up",			2],
			[22,	"left_deck_left",		2],
			[24,	"left_deck_right",		2],
			[26,	"left_deck_left",		2],
			[28,	"left_deck_up",			2],
			[30,	"left_analog_rotate",	16],
			[30,	"right_deck_up",		2],
			[31,	"right_deck_down",		2],
			[32,	"right_deck_up",		2],
			[33,	"right_deck_down",		2],
			[34,	"right_deck_up",		2],
			[35,	"right_deck_down",		2],
			[36,	"right_deck_up",		2],
			[37,	"right_deck_down",		2],
			[38,	"right_deck_up",		2],
			[39,	"right_deck_down",		2],
			[40,	"right_deck_up",		2],
			[41,	"right_deck_down",		2],
			[42,	"right_deck_up",		2],
			[43,	"right_deck_down",		2],
			[44,	"right_deck_up",		2],
			[45,	"right_deck_down",		2],
			[46,	"right_analog_rotate",	16],
			[46,	"left_deck_left",		2],
			[48,	"left_deck_right",		2],
			[50,	"left_deck_left",		2],
			[52,	"left_deck_up",			2],
			[54,	"left_deck_left",		2],
			[56,	"left_deck_right",		2],
			[58,	"left_deck_left",		2],
			[60,	"left_deck_up",			2]
		])
	)

	levels.append(levelClass.new("The Rave Party", "Testing", "Snabisch", 188, "res://assets/RaveParty.wav", 1,
		[
			[4, "left_deck_up", 4],
			[4, "right_analog_rotate", 28],
			[12, "left_deck_down", 4],
			[20, "left_deck_left", 4],
			[28, "left_deck_right", 4],
			[36, "right_deck_up", 4],
			[36, "left_analog_rotate", 28],
			[44, "right_deck_down", 4],
			[52, "right_deck_left", 4],
			[60, "right_deck_right", 4]
		])
	)
