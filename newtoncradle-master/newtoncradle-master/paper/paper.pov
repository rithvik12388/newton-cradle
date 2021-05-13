#include "colors.inc"
#include "functions.inc"

#local angleStep = 3;
#local sheetDim = <210, 1, 297>;
#declare paperDim = <1.75 * sheetDim.x, 5 * sheetDim.y, sqrt( pow( sheetDim.x, 2 ) + pow( sheetDim.z, 2 ) ) * cos( radians( 45 - angleStep * 5 ) ) >;



#local TPage = texture
{
	pigment
	{
		function
		{
			f_noise_generator( x, y, z, 3 )
		}
		colour_map
		{
			[ 0.0 rgbt<0.9, 0.9, 0.9, 0.5>]
			[ 0.7 rgbt<0.7, 0.7, 0.4, 0.5>]
			[ 1.0 rgbt<0.1, 0.1, 0.1, 0.5>]
		}
		scale 40 
	}
	finish
	{
		irid
		{
			0.25
		}
	}
}

#local Sheet = box
{
	<0, 0, 0>, sheetDim
	translate sheetDim / -2
}

#local Paper = object
{
	Sheet
	texture
	{
		TPage
	}
}


#local TitlePage = object
{
	Sheet
	texture
	{
		pigment
		{
			image_map
			{
				png "Prinicipia-title.png"
				map_type 0
			}
			translate <1, 1, 0> /- 2
			rotate <90, 0, 0>
			scale sheetDim 
		}
	}
	texture
	{
		TPage
		normal
		{
			wrinkles 3
		}
	}
}


#local WorkingPage = object
{
	Sheet
	texture
	{
		pigment
		{
			image_map
			{
				jpeg "Principia_Page_1726.jpg"
				map_type 0
			}
			translate <1, 1, 0> / -2
			rotate <90, 0, 0>
			scale sheetDim
		}
	}
	texture
	{
		TPage
		normal
		{
			wrinkles 3
		}
	}
}


#declare PaperStack = union
{
	#local curAngle = 0;
	object
	{
		Paper
		#local curAngle = curAngle + angleStep;
	}
	object
	{
		Paper
		translate sheetDim / 2 * <1, 0, -1>
		rotate <0, curAngle, 0>
		translate sheetDim / 2 * <-1, 0, 1>
		#local curAngle = curAngle + angleStep;
	}
	object
	{
		Paper
		translate sheetDim / 2 * <1, 1, -1>
		rotate <0, curAngle, 0>
		translate sheetDim / 2 * <-1, 0, 1>
		#local curAngle = curAngle + angleStep;
	}
	object
	{
		Paper
		translate sheetDim / 2 * <1, 2, -1>
		rotate <0, curAngle, 0>
		translate sheetDim / 2 * <-1, 0, 1>
		#local curAngle = curAngle + angleStep;
	}
	object
	{
		Paper
		translate sheetDim / 2 * <1, 3, -1>
		rotate <0, curAngle, 0>
		translate sheetDim / 2 * <-1, 0, 1>
		#local curAngle = curAngle + angleStep;
	}
	object
	{
		WorkingPage
		translate sheetDim / 2 * <1, 4, -1>
		rotate <0, curAngle, 0>
		translate sheetDim / 2 * <-1, 0, 1>
	}
	object
	{
		TitlePage
		translate sheetDim * <-0.75, 0, 0>
	}
	translate <sheetDim.x / 1.75, -2, 0>
}

