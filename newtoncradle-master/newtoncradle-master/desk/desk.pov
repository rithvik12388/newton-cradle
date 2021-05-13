#include "colors.inc"
#include "textures.inc"
#include "woods.inc"


#declare deskDim = <100, 15, 45>;

#declare Desk = 
superellipsoid
{
	<0.1, 0.1>
	scale deskDim / 2
	translate deskDim / 2
	texture
	{
		pigment
		{
			wood
			turbulence 0.10 
			colour_map
			{
				[0.1 rgb <0.07,0.01,0>]
				[1.0 rgb <0.03, 0.01, 0>]
			}
			rotate <0, 90, 0>
			scale 1
		}
		finish
		{
			phong 0.05 
			diffuse 1
			reflection
			{
				0.02
			}
		}
		normal
		{
			wood 0.5
			rotate 90 * y
		}
	}
	translate deskDim / -2
}
