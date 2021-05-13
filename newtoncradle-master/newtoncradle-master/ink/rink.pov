#include "ink.pov"


camera
{
	location <0, 100, -200>
	look_at <0, 0, 0 >
}

light_source
{
	<0, 0, -50>
	color White
}

background
{
	color Blue
}

plane
{
	y, quillAndPotDim.y / -2
	texture
	{
		pigment
		{
			color White
		}
	}
}

QuillAndPot

