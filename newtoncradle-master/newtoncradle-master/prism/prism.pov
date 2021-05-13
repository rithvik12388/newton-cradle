#include "colors.inc"
#include "glass.inc"

#local prismLength = 10;
#local facePerimeter = 12;

#declare prismDim = <prismLength, facePerimeter / 3 / cos( pi / 6), facePerimeter / 3>;



#declare GlassPrism = prism
{
	linear_sweep
	0, prismLength, 4, /* Top of prism, bottom of prism, number of points */
	<0, 0>, <0, facePerimeter / 3>, < ( facePerimeter / 3 ) / cos( pi / 6 ), facePerimeter / 6>, <0, 0>
	texture
	{
		pigment
		{
			Col_Glass_General
		}
		finish
		{
			F_Glass10
			irid
			{
				0.3
				thickness 0.2 
				turbulence 0.3
			}
		}
	}
	interior
	{
		ior 1.5
		dispersion 1.2
		fade_distance 1
	}
	rotate <0, 0, 90>
	translate prismDim * <0.5, -0.5, -0.5> 
}

