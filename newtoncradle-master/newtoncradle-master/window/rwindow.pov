#include "window.pov"


camera
{
	location frameDim + <0, 0, frameDim.z * 10>
	look_at <0, 0, 0>
}

light_source
{
	frameDim * 2
	color White
}

plane
{
	y, frameDim.y / -2
	texture
	{
		pigment
		{
			color Red
		}
	}
}


WindowInFrame
