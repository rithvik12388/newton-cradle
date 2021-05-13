#include "tree.pov"
#include "functions.inc"


camera
{
/*	location <treeDim.x * cos( clock * 2 * pi ), treeDim.y / 2 * sin( clock * 2 * pi ) + treeDim.y / 2, -50>*/
	/*location < treeDim.x * -2, treeDim.y / 2, treeDim.z * -2>*/
	location <0, treeDim.y / 2, treeDim.z * -4>
	look_at <0, treeDim.y / 2, 0>
}

light_source
{
	<0, treeDim.y / 2,-treeDim.z>
	color White
}

light_source
{
	<0, treeDim.y, -treeDim.z / 2>
	color White
}

/*
camera
{
	location < 0, 40, -30 >
	look_at <0, 20, 0>
}

light_source
{
	<0, 40, -20>
	color White
}*/

plane
{
	<0, 1, 0>, 0
	texture
	{
		pigment
		{
			checker color Red color Blue 
		}
	}
}

/*
object
{
	Leaf
	scale 2
	translate <0, 25, 0>
}*/

/*
object
{
	Apple
	scale 2
	translate <0, 20, 0>
}*/


object
{
	Tree
	translate <0, treeDim.y / 2, 0>
}
