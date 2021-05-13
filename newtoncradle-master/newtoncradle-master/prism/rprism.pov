#include "prism.pov"


camera
{
	location prismDim * 2
	look_at <0, 0, 0>
}

light_source
{
	prismDim
	color White
}


light_source
{
	<0, 3, 1>, color Red
       	cylinder
	point_at <0, -3, 1>
}

plane
{
	<0, 1, 0>, -0.5
	texture
	{
		pigment
		{
			color Green
		}
	}
}

GlassPrism
