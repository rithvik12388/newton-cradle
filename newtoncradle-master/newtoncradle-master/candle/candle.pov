#include "colors.inc"
#include "functions.inc"
#include "glass.inc"
#include "metals.inc"
#include "textures.inc"

#local fireRadius = 8;
#declare candleDim = <160, 210, 160>;

#local HolderBase = lathe
{
	quadratic_spline
	25/* Number of points */
	<-1, 0>, <0, 0.0>,
       	<95, 0.0>, <100, 8.8>, <85, 26.2>, <90, 35.0>, /* Two rings at bottom*/
	<50, 40.2>, <40, 52.5>, <37, 52.5>, <33, 59.5>, <22, 63.0>, /*Up to start of neck */
	<12, 78.8>, <10, 78.8>, <10, 87.5>, <50, 96.2>, <100, 112.0>, /*Up to edge of bowl */
	<50, 99.8>, <25, 94.5>, <27, 98.0>, <27, 122.5>, <32, 126.0>, <29, 122.5>, <0, 122.5>,
	<0, 0.0>, <-1, 0>
}	

#local Handle = sphere_sweep
{
	b_spline
	8,/* Number of spheres */
	<-10, 0, 0>, 2.5,
	<-9, 0, 0>, 2.5 
	<100, 0, 0>, 2.5,
	<160, 40, 0>, 2.5,
	<125, 120, 0>, 2.5,
	<70, 50, 0>, 1,
	<140, 55, 0>, 0.1,
	<141, 55, 0>, 0.1 
}

#local Holder = union
{
	object
	{
		HolderBase
	}
	object
	{
		Handle
		translate <0, 84, 0>
	}
	texture
	{
		pigment
		{
			color P_Brass1 / 2
		}
		normal
		{
			dents 2 
			scale 15
		}
		finish
		{
			F_MetalA
		}
	}
}


#local Fire = isosurface
{
	#local mult = 0.45;
	function
	{

		f_noise_generator( mult * x, mult * y - clock * 6, mult * z, 3 ) - 0.35
	}

	max_gradient 500
	threshold 0 

	contained_by
	{
		sphere
		{
			<0, 0, 0>, fireRadius
		}
	}

	hollow
	texture
	{
		pigment
		{
			gradient y
			colour_map
			{
				[0.0 rgbt<0.35, 0, 0.7, 0.5>]
				[0.3 rgbt<0.75, 0.4, 0.01, 0.5>]
				[0.4 rgbt<0.9, 0.9, 0.9, 0.5>]
				[0.85 rgbt<0.75, 0.4, 0.01, 0.5>]
				[1.0 rgbt<0.4, 0.2, 0, 0.5>]
			}
			scale 16
			translate <0, 8, 0>

		}
		finish
		{
			ambient 1.5 
			diffuse 1
		}
	}
	interior
	{
		I_Glass2
	}
	scale <0.75, 1.2, 0.75>
}

#local Candle = union
{
	difference
	{
		cylinder
		{
			<0, 0, 0>, <0, 90, 0>, 26
		}
		sphere
		{
			<15, 95, -20>, 13
		}
		sphere
		{
			<-5, 93, 0>, 20 
		}
		sphere
		{
			<10, 93, 10>, 15
		}

		texture
		{
			pigment
			{
				function
				{
					(x*x + z*z) / (27*27)
				}
				colour_map
				{
					[0.0 White]
					[0.8 White]
					[1.0 rgbf<0.9,0.85, 0.3, 0.1>]
				}
			}
			normal
			{
				ripples 0.5 
			}
			finish
			{
				phong 0.1
				diffuse 0.5
			}
		}
	}
	cylinder /* The wax */
	{
		<0, 60, 0>, <0, 80, 0>, 20
		texture
		{
			pigment
			{
				Col_Glass_General
			}
			normal
			{
				waves	
				translate <5, 0, 0>
			}
			finish
			{
				F_Glass5
			}
		}
	}
	sphere_sweep /* The wick */
	{
		linear_spline
		5,
		<0, 60, 0>, 1,
		<1, 81, 1>, 1,
		<1, 83, 0>, 1.5,
		<-1, 85, 1>, 1,
		<-2, 87, 0>, 0.5 
		texture
		{
			pigment
			{
				color Black
			}
		}
	}
	#local randSeed = seed( clock * 30 + 2);
	object /* The fire */
	{
		light_source
		{
			<0, 0, 0>
			color rgb <1, 0.2 + 0.2 * rand( randSeed ), 0>
			area_light fireRadius / -2 - rand(randSeed), fireRadius / 2 + rand( randSeed ), 2, 2
			adaptive 1
			jitter
			looks_like
			{
				Fire
			}
		}
		translate <0, 90, 0>
	}
}


#declare CandleHolder = union
{
	object
	{
		Holder
	}
	object
	{
		Candle
		translate <0, 122, 0>
	}
	translate <0, candleDim.y / -2, 0>
}
