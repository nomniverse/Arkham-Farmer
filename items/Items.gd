extends Node


enum {
	NO_ITEM = 0,
	WATER_CAN = 1,
	SHOVEL = 2,
	AXE = 3,
	LOG = 4,
	CORN_SEEDS = 5,
	CORN = 6,
	EGG = 7,
	APPLE = 8,
	REVOLVER = 9,
}

enum ItemType {
	NULL,
	BLOCK,
	ITEM,
	TOOL,
	RANGED_WEAPON,
	MELEE_WEAPON,
	CROP,
	FOOD
}

var item_properties = {
	NO_ITEM: {
		"name": "",
		"icon": Rect2(192, 192, 16, 16),
		"item_type": ItemType.NULL
	},
	WATER_CAN: {
		"name": "Watering Can",
		"icon": Rect2(112, 80, 16, 16),
		"item_type": ItemType.TOOL
	},
	SHOVEL: {
		"name": "Shovel",
		"icon": Rect2(128, 80, 16, 16),
		"item_type": ItemType.TOOL
	},
	AXE: {
		"name": "Axe",
		"icon": Rect2(144, 80, 16, 16),
		"item_type": ItemType.TOOL
	},
	LOG: {
		"name": "Log",
		"icon": Rect2(160, 176, 16, 16),
		"item_type": ItemType.BLOCK
	},
	CORN_SEEDS: {
		"name": "Corn Seeds",
		"icon": Rect2(96, 64, 16, 16),
		"item_type": ItemType.CROP
	},
	CORN: {
		"name": "Corn",
		"icon": Rect2(32, 64, 16, 16),
		"item_type": ItemType.FOOD
	},
	EGG: {
		"name": "Egg",
		"icon": Rect2(96, 32, 16, 16),
		"item_type": ItemType.ITEM
	},
	APPLE: {
		"name": "Apple",
		"icon": Rect2(112, 64, 16, 16),
		"item_type": ItemType.FOOD
	},
	REVOLVER: {
		"name": "Revolver",
		"icon": Rect2(176, 176, 16, 16),
		"item_type": ItemType.RANGED_WEAPON
	}
}
