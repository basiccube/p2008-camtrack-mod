DBG <- 1

FIRST_MAP_WITH_CAMERA <- "ct_box_on_top"

MapPlayOrder <- [
	// Intro
	"ct_intro",
	
	// Camera Intro
	"ct_camera_intro",
	"ct_box_on_top",
	
	// Fans
	"ct_fan_intro",
	"ct_fan_reuse",
]

function DumpMapList()
{
	if (DBG)
	{
		local mapcount = 0
		
		printl("================DUMPING MAP PLAY ORDER")
		
		foreach (index, map in MapPlayOrder)
		{
			if (GetMapName() == MapPlayOrder[index])
				printl(index + " " + MapPlayOrder[index] + " <--- You Are Here")
			else
				printl(index + " " + MapPlayOrder[index])
			mapcount++
		}
		printl(mapcount + " maps total.")
		
		printl("================END DUMP")
	}
}

function OnPostSpawn()
{
	DumpMapList()
	
	// Give the player the camera
	local giveCamera = false
	foreach (index, map in MapPlayOrder)
	{
		if (MapPlayOrder[index] == FIRST_MAP_WITH_CAMERA)
			giveCamera = true
			
		if (GetMapName() == MapPlayOrder[index])
			break
	}
	
	if (giveCamera)
		EntFire("@command", "command", "give weapon_camera", 0.5)
}

function TransitionFromMap()
{
	foreach (index, map in MapPlayOrder)
	{
		if (GetMapName() == MapPlayOrder[index])
		{
			if (index + 1 >= MapPlayOrder.len())
			{
				if (DBG)
					printl("Map " + GetMapName() + " is the last map")
				EntFire("@map_end_text", "display", 0)
			}
			else
			{
				if (DBG)
					printl("Map " + GetMapName() + " connects to " + MapPlayOrder[index + 1])
				EntFire("@command", "command", "changelevel " + MapPlayOrder[index + 1], 1.3)
			}
		}
	}
}