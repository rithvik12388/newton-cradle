#include "colors.inc"
#include "textures.inc"
#include "woods.inc"
#include "glass.inc"
#include "stones.inc"

/* Dimensions of a single window */
#declare windowDim = < 60, 100, 15>;

/* Dimensions of the pane of glass inside of the window */
#local paneRatio = <0.8, 0.9, 0.2>;
#local paneDim = windowDim * paneRatio;

/* Dimensions of the frame that the two windows will sit in */
#local frameRatio = < 2.2, 1.1, 1 >;
#declare frameDim = frameRatio * windowDim;
#local frameGap = 0.2 * 60 * 0.04;

/* Position on the window, height and radius of the hinges */
#local hingeYPos = windowDim.y * 0.7;
#local hingeHeight = windowDim.y * 0.15;
#local hingeRadius = windowDim.z * 0.07;

/* Depth of the crossbars */
#local crossDepth = paneRatio.z * 1.5 * windowDim.z;

#local knobRatio = <0.1, 0.04, 0.5>;
#local knobDim = knobRatio * windowDim;


#local TFrame = texture
{
	T_Wood4
	scale 20
	rotate <90, 0, 0 >
}



/* Creates a frame centered at 0 */
#macro makeFrame( dim, sf )
	#local halfDim = dim / 2;
	#local halfInner = sf * dim / 2;
	
	union
	{
		box
		{
			-halfDim, halfDim * <0, 1, 1> + halfInner * <-1, 0, 0>
		}
		box
		{
			-halfDim, halfDim * <1, 0, 1> + halfInner * <0, -1, 0>
		}
		box
		{
			halfDim, halfDim * <-1, 0, -1> + halfInner * <0, 1, 0>
		}
		box
		{
			halfDim, halfDim * <0, -1, -1> + halfInner * <1, 0, 0>
		}
	}
#end
	

#local Knob = box
{
	<0, 0, 0>, <1, 1, 1>
	translate <1, 1, 1> / -2
	rotate <0, 0, 45>
	scale ( 1 / sqrt( 2 ) )
	scale knobDim
	texture
	{
		T_Grnt21
	}
}


#local Hinge = union
{
	cylinder
	{
		< 0, 0, 0 >, <0, hingeHeight * 0.40, 0>, hingeRadius
	}
	cylinder
	{
		< 0, hingeHeight * 0.40, 0 >, <0, hingeHeight * 0.60, 0 >, hingeRadius * 0.8
		texture
		{
			T_Grnt15
		}
	}
	cylinder
	{
		< 0, hingeHeight * 0.60, 0 >, < 0, hingeHeight, 0 > hingeRadius
	}
	texture
	{
		T_Stone20
	}
	translate < 0, -hingeHeight / 2, 0 >
}


#local Window = union
{
	object /* The frame for the window */
	{
		makeFrame( windowDim, paneRatio )
		texture
		{
			TFrame
		}
	}
	box /* The glass pane */
	{
		< 0, 0, 0 >, paneDim
		hollow
		texture
		{
			pigment
			{
				Col_Glass_General
			}
			finish
			{
				F_Glass5
				specular 0.3
				
			}
		}
		interior
		{
			ior 1.5
			dispersion 1.12
		}

		translate paneDim / -2
	}
	union
	{
		box /* Vertical cross bar */
		{
			<0, 0, 0>, <crossDepth, paneDim.y, crossDepth>
			translate <crossDepth, paneDim.y, crossDepth> / -2
			rotate < 0, 45, 0 >
		}
		box /* Horizontal cross bar */
		{
			<0, 0, 0>, <paneDim.x, crossDepth, crossDepth>
			translate < paneDim.x, crossDepth, crossDepth > / -2
			rotate < 45, 0, 0 >
		}
		texture
		{
			TFrame
		}
	}
	object
	{
		Hinge
		translate < windowDim.x, hingeYPos, -windowDim.z - 2 * hingeRadius > / 2
	}
	object
	{
		Hinge
		translate < windowDim.x, -hingeYPos, -windowDim.z - 2 * hingeRadius > / 2
	}
}


#declare WindowInFrame = union
{
	object
	{
		Window
		translate <windowDim.x + frameGap, 0, 0> / 2
	}
	object
	{
		Window
		scale <-1, 1, 1>
		translate -<windowDim.x + frameGap, 0, 0> / 2
	}
	object
	{
		Knob
		translate < ( windowDim.x - paneDim.x ) / 4, 0, -windowDim.z / 2 - knobDim.z / 2>
	}
	object
	{
		/* We have to halve the y and z because the frame needs to hold TWO
       		windows */	
		#local wndFrame = windowDim * < 2, 1, 1 > + 2 * frameGap;
		makeFrame( frameDim, wndFrame / frameDim )
		texture
		{
			TFrame
		}
	}
}

