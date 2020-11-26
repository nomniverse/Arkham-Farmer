extends Node


enum Item {
	NO_ITEM = 0,
	WATER_CAN = 1,
	SHOVEL = 2,
	AXE = 3,
	LOG = 4,
	CORN_SEEDS = 5,
	CORN = 6,
	EGG = 7,
}

var item_properties = {
	Item.NO_ITEM: {
		"name": "",
		"icon": Rect2(176, 176, 16, 16)
	},
	Item.WATER_CAN: {
		"name": "Watering Can",
		"icon": Rect2(112, 80, 16, 16)
	},
	Item.SHOVEL: {
		"name": "Shovel",
		"icon": Rect2(128, 80, 16, 16)
	},
	Item.AXE: {
		"name": "Axe",
		"icon": Rect2(144, 80, 16, 16)
	},
	Item.LOG: {
		"name": "Log",
		"icon": Rect2(160, 176, 16, 16)
	},
	Item.CORN_SEEDS: {
		"name": "Corn Seeds",
		"icon": Rect2(96, 64, 16, 16)
	},
	Item.CORN: {
		"name": "Corn",
		"icon": Rect2(32, 64, 16, 16)
	},
	Item.EGG: {
		"name": "Egg",
		"icon": Rect2(96, 32, 16, 16)
	}
}
