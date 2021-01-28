extends Node

enum {
	NO_ITEM,
	WATER_CAN,
	PICKAXE,
	AXE,
	HOE,
	LOG,
	CORN_SEEDS,
	CORN,
	EGG,
	APPLE,
	REVOLVER,
	BULLET,
	FENCE,
	BOX,
}

enum ItemType {
	NULL,
	BLOCK,
	CONTAINER,
	ITEM,
	TOOL,
	RANGED_WEAPON,
	AMMO,
	MELEE_WEAPON,
	CROP,
	FOOD,
}

var TRANSPARENT_TEXTURE_PATH = load("res://assets/transparent_tile.png")
var ANIMALS_TEXTURE_PATH = load("res://assets/Farming and Mining/Animals.png")
var CITIZENS_TEXTURE_PATH = load("res://assets/Farming and Mining/Citizens.png")
var CLOTHING_TEXTURE_PATH = load("res://assets/Farming and Mining/ClothingArmor.png")
var ENVIRONMENT_TEXTURE_PATH = load("res://assets/Farming and Mining/Environment.png")
var FENCE_TEXTURE_PATH = load("res://assets/Farming and Mining/Fence.png")
var FRUITS_VEG_SEED_TEXTURE_PATH = load("res://assets/Farming and Mining/FruitsVegSeed.png")
var FURNITURE_TEXTURE_PATH = load("res://assets/Farming and Mining/Furniture.png")
var HAIR_TEXTURE_PATH = load("res://assets/Farming and Mining/Hair.png")
var MINERALS_TEXTURE_PATH = load("res://assets/Farming and Mining/Minerals.png")
var REFINED_MATERIALS_TEXTURE_PATH = load("res://assets/Farming and Mining/RefinedMaterials.png")
var THOUGHT_BUBBLE_TEXTURE_PATH = load("res://assets/Farming and Mining/ThoughtBubbles.png")
var TOOLS_TEXTURE_PATH = load("res://assets/Farming and Mining/Tools.png")

var item_properties = {
	NO_ITEM: {
		"name": "",
		"texture_file": TRANSPARENT_TEXTURE_PATH,
		"icon": Rect2(0, 0, 32, 32),
		"item_type": ItemType.NULL
	},
	WATER_CAN: {
		"name": "Watering Can",
		"texture_file": TOOLS_TEXTURE_PATH,
		"icon": Rect2(0, 288, 32, 32),
		"item_type": ItemType.TOOL
	},
	PICKAXE: {
		name: "Pickaxe",
		"texture_file": TOOLS_TEXTURE_PATH,
		"icon": Rect2(0, 0, 32, 32),
		"item_type": ItemType.TOOL
	},
	AXE: {
		"name": "Axe",
		"texture_file": TOOLS_TEXTURE_PATH,
		"icon": Rect2(0, 32, 32, 32),
		"item_type": ItemType.TOOL
	},
	HOE: {
		"name": "Hoe",
		"texture_file": TOOLS_TEXTURE_PATH,
		"icon": Rect2(0, 64, 32, 32),
		"item_type": ItemType.TOOL
	},
	LOG: {
		"name": "Log",
		"texture_file": ENVIRONMENT_TEXTURE_PATH,
		"icon": Rect2(352, 32, 32, 32),
		"item_type": ItemType.BLOCK
	},
	CORN_SEEDS: {
		"name": "Corn Seeds",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(128, 224, 32, 32),
		"item_type": ItemType.CROP
	},
	CORN: {
		"name": "Corn",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(32, 64, 32, 32),
		"item_type": ItemType.FOOD
	},
	EGG: {
		"name": "Egg",
		"texture_file": ANIMALS_TEXTURE_PATH,
		"icon": Rect2(224, 64, 32, 32),
		"item_type": ItemType.ITEM
	},
	APPLE: {
		"name": "Apple",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(0, 0, 32, 32),
		"item_type": ItemType.FOOD
	},
	REVOLVER: {
		"name": "Revolver",
		"texture_file": TOOLS_TEXTURE_PATH,
		"icon": Rect2(0, 320, 32, 32),
		"item_type": ItemType.RANGED_WEAPON,
		"capacity": 6
	},
	BULLET: {
		"name": "Bullet",
		"texture_file": TOOLS_TEXTURE_PATH,
		"icon": Rect2(0, 352, 32, 32),
		"item_type": ItemType.AMMO
	},
	FENCE: {
		"name": "Fence",
		"texture_file": FENCE_TEXTURE_PATH,
		"icon": Rect2(0, 96, 32, 32),
		"item_type": ItemType.BLOCK
	},
	BOX: {
		"name": "Box",
		"texture_file": FURNITURE_TEXTURE_PATH,
		"icon": Rect2(0, 0, 32, 32),
		"item_type": ItemType.CONTAINER,
		"empty_icon": Rect2(32, 0, 32, 32)
	}
}
