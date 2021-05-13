#include "colors.inc"
#include "functions.inc"
#include "stones.inc"
#include "textures.inc"
#include "glass.inc"

#local potDim = <110, 104, 110>;
#local quillDim = < 30, 256, 17>;
#declare quillAndPotDim = <110, 300, 110>;


#local Pot = lathe
{
	cubic_spline
	21, /* Number of points */
	<0, 0>, <0, 0>, /* These points only exist for the interpolation */
	<0, 0>, <50, 0>, <55, 5>, /* Bottom of pot */
	<40, 40>, <30, 70>, <35, 75>, /* First ring */
	<28, 80>, <26, 82>, <28, 84>, /* Second ring */
	<25, 85>, <22, 87>, <22, 95>, /* Up to lip */
	<26, 96>, <26, 104>, <20, 104>, <20, 50>,  /* Up to top */
	<0, 50>, <0, 0>, <0, 0> /* only here for the interpolation */
}


/* This has to be copied otherwise we have to use a difference
and differences are terrible */
#local Ink = lathe
{
	cubic_spline
	14, /* Number of points */
	<0, 0>, <0, 0>, /* These points only exist for the interpolation */
	<0, 0>, <50, 0>, <55, 5>, /* Bottom of pot */
	<40, 40>, <30, 70>, <35, 75>, /* First ring */
	<28, 80>, <26, 82>, <28, 84>, /* Second ring */
	<0, 84>, <0, 84>, <0, 0> /* only here for the interpolation */
	scale <0.85, 1, 0.85>
}


#local InkPot = union
{
	object
	{
		Pot
		hollow
		texture
		{
			pigment
			{
				Col_Glass_General
			}
			finish
			{
				specular 0.7
				roughness 0.001
				ambient 0
				diffuse 0
				reflection
				{
					0.005
				}
				conserve_energy

			}
		}
		interior
		{
			I_Glass_Dispersion1
		}
	}
	object
	{
		Ink
		texture
		{
			pigment
			{
				color Black
			}
			finish
			{
				diffuse 0.1
			}
		}
	} 
}


#macro makeWizzle( wingSpan, height, thick, sectorHeight )
	/* +0.01 is to avoid divide by zero errors */
	#local r = ( wingSpan + 0.01 ) / (2 * sqrt( 1 - pow( sectorHeight, 2 ) ) );
	difference
	{
		sphere
		{
			<0, 0, 0>, r
		}
		sphere
		{
			<0, 0, 0>, r
			translate <2* thick / r, 0, 0>
		}
		box
		{
			<-sectorHeight * r, -r, -r>, <r, r, r>
		}
		box
		{
			<-r, height / 2, -r>, <r, r, r>
		}
		box
		{
			<-r, -height / 2, -r>, <r, -r, r>
		}	
	}
	translate <r, 0, 0 >
	rotate <0, -90, 0>
#end


#local Quill = union
{
	sphere_sweep
	{
		cubic_spline
		13, /*Number of points */
		<0, 0, 0>, 5,
		<0, 0, 0>, 5,
		<0, 90, 0>, 5,
		<0, 110, 0.5>, 5,
		<0, 113, 1>, 5,
		<0, 117, 1.5>, 5,
		<0, 120, 2>, 4.5,
		<0, 160, 3>, 3,
		<0, 180, 5>, 2.2,
		<0, 220, 8>, 1.4,
		<0, 235, 11>, 0.8,
	        <0, 256, 15>, 0.5,
		<0, 256, 17>, 0.5
		texture
		{
			pigment
			{
				color White
			}
		}
	}

	#local sectorHeight = 0.75;
	#local height = 200;
	#local yStart = 104; #local yEnd = quillDim.y; #local yStep = ( yEnd - yStart ) / height;
	#local yPos = yStart;
	#local zStart = -5; #local zEnd = quillDim.z; #local zStep = (zEnd - zStart) / height;
	#local zPos = zStart;
	#local randSeed = seed(2);

	#while( yPos < yEnd & zPos < zEnd )
		object
		{
			/* algorithms and shit */
			#local wizzleWidth = pow( sin( ( zPos - zStart ) / (zEnd - zStart) * pi ), 0.3 ) * 2.5 * quillDim.x;
			/* Give some turbulence to make it more realistic */
			#local wizzleWidth = wizzleWidth - rand( randSeed ) * quillDim.x * 0.5;
			
			makeWizzle( wizzleWidth, (yEnd - yStart) / height, zStep, sectorHeight )
			rotate < 0, 0, (rand( randSeed ) - 0.5) * 3>
			translate <0, yPos, zPos>
			texture
			{
				pigment
				{
					gradient x
					colour_map
					{
						[0.3 Black]
						[0.5 rgbt <0, 0, 0, 0.05>]
						[0.7 Black]
					}
					scale 63 

				}
				normal
				{
					bozo
				}
				finish
				{
					phong 0.5
					diffuse 0.1
				}

			}
		}
		#local yPos = yPos + yStep;
		#local zPos = zPos + zStep;
	#end

	translate quillDim * <0, -0.5, -0.5>
}	


#declare QuillAndPot = union
{
	object
	{
		InkPot
	}
	object
	{
		Quill
		rotate < 30, 0, 0>
		translate <0, potDim.y + (quillAndPotDim.y - quillDim.y), potDim.z / 2.5>
	}
	translate <0, quillAndPotDim.y / -2, 0 >
}

