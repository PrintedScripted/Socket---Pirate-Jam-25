extends Node

var poly_amount: int = 0

#Research
var research_cost_poly: int = 0
var research_cost_flux: int = 0
var research_cost_increase_percent: float

var research_options_common: Array = []
var research_options_rare: Array = []
var research_options_weapons: Array = []

var researched_nodes: Array = []



#Dictionary Guide
# 3 types, triggers, spawn, and attributes
#
#Triggers are for things that will cause more damage OnHit, or OnDeath
#Spawns are for things that will spawn more projectiles OnHit, OnDeath, or OnDespawn. They typically decrease projectile lifespan.
#Attributes are for things that will modify the behavior of the projectile, enemies, or other objects. They typically have Range.

var nodes: Dictionary = {
	"triggers" : {
		"Explosion" : {
			"Collector": {"Trigger" : "OnDeath", "Range" : 40},
			"Projectile": {"Trigger" : "OnHit", "Range" : 40, "fluxCost" : 1}
			}
		},

	"spawns" : {
		"a" : null
	},

	"attributes" : {
		"Frost" : {
			"Collector": {"Trigger" : "InRange", "Range" : 100},
			"Projectile": {"Trigger" : "OnHit", "SpeedDecrease" : 200}
		},
		"Poison" : {
			"Collector": {}
		}
	}
}
