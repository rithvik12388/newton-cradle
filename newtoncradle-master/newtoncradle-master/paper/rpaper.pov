#include "paper.pov"


camera
{
	location <0, 400, 0> 
	look_at <0, 0, 0>
}

light_source
{
	<0, 300, 0>	
	color White
}

object
{
	PaperStack
/*	translate <paperDim.x, 0, 0>*/
}
