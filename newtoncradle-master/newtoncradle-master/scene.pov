#include "colors.inc"
#include "math.inc"
#include "candle/candle.pov"
#include "cradle/cradle.pov"
#include "window/window.pov"
#include "desk/desk.pov"
#include "paper/paper.pov"
#include "prism/prism.pov"
#include "ink/ink.pov"
#include "tree/tree.pov"


/* The Pos variables are the position of the centrepoint of the object*/
/* The Scaled variables are the dimensions of the object once scaled to
   fit the screen */

#local deskLen = 150;
#local deskSF = deskLen / deskDim.x;
#local deskPos = <0, deskDim.y, deskDim.z / 2> * deskSF;
#local sDeskDim = deskDim * deskSF;
#local deskRot = <0, 0, 0>;


/* The wall and window are highly coupled. The wall should have been part of the window */
#local windowLen = 100;
#local windowSF = windowLen / frameDim.x;
#local wallSF = < 4, 4, 2 >; 
#local wallPos = < 0, frameDim.y / 2, 0> * windowSF + deskPos + <0, sDeskDim.y, sDeskDim.z / 2 + wallSF.z * frameDim.z>;
#local sWallDim = frameDim * windowSF * wallSF;
#local sWindowDim = frameDim * windowSF;
#local windowPos = wallPos;
#local windowRot = <0, 0, 0>;

#local cradleLen = 20;
#local cradleSF = cradleLen / cradleDim.x;
#local cradlePos = <0, cradleDim.y / 2, 0> * cradleSF + deskPos + sDeskDim * <-0.25, 0.5, -0.35>;
#local cradleRot = <0, -45, 0>;


#local candleLen = 30;
#local candleSF = candleLen / candleDim.x;
#local candlePos = <0, candleDim.y / 2, 0> * candleSF + deskPos + sDeskDim * <-0.3, 0.5, 0.1>;
#local candleRot = <0, 0, 0>;

#local stackLen = 21 * 1.75;
#local stackSF = stackLen / paperDim.x;
#local stackPos = <0, paperDim.y / 2, 0> * stackSF + deskPos + sDeskDim * <0.10, 0.5, -0.2>;
#local stackRot = <0, 20, 0>;


#local prismLen = 15;
#local prismSF = prismLen / prismDim.x;
#local prismPos = <0, prismDim.y / 2, 0> * prismSF + deskPos + sDeskDim * <0.05, 0.5, 0 >;
#local prismRot = <0, 40, 0>;

#local potLen = 8;
#local potSF = potLen / quillAndPotDim.x;
#local potPos = <0, quillAndPotDim.y / 2, 0> * potSF + deskPos + sDeskDim * <0.35, 0.5, -0.15>;
#local potRot = <0, 55, 0>;


#local treeLen = 300;
#local treeSF = treeLen / treeDim.x;
#local treePos = <0, treeDim.y / 2, 0> * treeSF + sDeskDim * <-1.2, 0, 20>;
#local treeRot = <0, 0, 0>;


#local rainbowLen = 4;
#local rainbowPos = prismPos - <0, prismDim.y / 2, 0> * prismSF;
#local rainbowEnd = deskPos + sDeskDim * <-0.15, 0.5, -0.5>;

#local sunPos = <10, 100, 40>;

#local cameraPos = <10, 80, -75>;



object
{
	Desk
	scale deskSF
	rotate deskRot
	translate deskPos
}



object
{
	Cradle
	scale cradleSF
	rotate cradleRot
	translate cradlePos
}


object
{
	CandleHolder
	scale candleSF
	rotate candleRot
	translate candlePos
}

object
{
	PaperStack
	scale stackSF
	rotate stackRot
	translate stackPos
}

object
{
	GlassPrism
	scale prismSF
	rotate prismRot
	translate prismPos
}

object
{
	QuillAndPot
	scale potSF
	rotate potRot
	translate potPos
}



object
{
	Tree
	scale treeSF
	rotate treeRot
	translate treePos
}


object
{
	WindowInFrame
	scale windowSF
	rotate windowRot
	translate windowPos
}


/* The wall */
#declare Wall = object
{
	makeFrame( sWindowDim * wallSF, 1 / wallSF )
	texture
	{
		pigment
		{
			color rgb <0.65, 0.5, 0.35> * 0.5
		}
		normal
		{
			crackle form <-1, 1, 0>
			scale 2
		}
	}
}


object
{
	Wall
	translate wallPos
}


/* Back wall (not in picture) blocks out light */
object
{
	Wall
	scale <4, 4, 1>
	translate wallPos * <-1, 1, -1>
}

/* Side wall*/
object
{
	Wall
	scale <4, 4, 1>
	rotate <0, 90, 0>
	translate <sWallDim.x, wallPos.y, 0>
}

/* Other side wall */
object
{
	Wall
	scale <4, 4, 1>
	rotate <0, -90, 0>
	translate <-sWallDim.x, wallPos.y, 0>
}

/* Roof (not in the picture */
box
{
	0, <wallPos.x, deskDim.y, wallPos.z * 4>
	translate <wallPos.x, deskDim.y, wallPos.z * 4> / -2
	translate <wallPos.x, wallPos.y + sWallDim.y / 2, wallPos.z - wallPos.z * 2>
}


/* Floor (not visible [usually] ) */
box
{
	0, <sWallDim.x, 1, wallPos.z * 2>
	texture
	{
		pigment
		{
			color Brown
		}
	}
	translate <sWallDim.x - 2, 0, wallPos.z * -2>
}


/* These colours are from the povray tutorial */
#local trans = 0.95;
#local r_violet = color rgbt<1.0, 0.5, 1.0, trans>;
#local r_indigo  = color rgbt<0.5, 0.5, 1.0, trans>;
#local r_blue    = color rgbt<0.2, 0.2, 1.0, trans>;
#local r_green   = color rgbt<0.2, 1.0, 0.2, trans>;
#local r_yellow  = color rgbt<1.0, 1.0, 0.2, trans>;
#local r_orange  = color rgbt<1.0, 0.5, 0.2, trans>;
#local r_red    = color rgbt<1.0, 0.2, 0.2, trans>;

/* The rainbow */
box
{
	#local length = VDist( rainbowLen, rainbowPos );
	0, <rainbowLen, 0.8, length>
	texture
	{
		pigment
		{
			gradient x
			colour_map	
			{
				[0/6 r_violet]
				[1/6 r_indigo]
				[2/6 r_blue]
				[3/6 r_green]
				[4/6 r_yellow]
				[5/6 r_orange]
				[6/6 r_red]
			}
			scale rainbowLen
		}
	}
	translate <-rainbowLen / 2, -0.5, 0>
	rotate <0, 180, 0>
	rotate <0, VAngleD( ( rainbowEnd - rainbowPos ), <0, 0, -1> ), 0>
	translate rainbowPos
}


camera
{
	location cameraPos
	look_at < 0, cameraPos.y / 2, 500>
}


light_source
{
	sunPos
	color White
	area_light
       	<5, 2.5, 0>, <0, -2.5, 5>, 5, 5
	adaptive 1
	jitter
}

light_source
{
	<0, windowPos.y, -wallPos.z>
	color White
	fade_distance wallPos.z
	fade_power 3 
}

plane
{
	<0, 1, 0>, 0
	texture
	{
		pigment
		{
			bozo
			colour_map
			{
				[0.0 rgb <0, 0.7, 0>]
				[1.0 rgb <0. 0.2, 0>]
			}
			scale 3
		}
		normal
		{
			bozo 1
			scale 100
		}
		finish
		{
			diffuse 0.05
		}
	}
}


/* This sky_sphere is shamelessly stolen from the povray tutorial */
sky_sphere
{
	pigment
	{
		gradient y
		color_map
		{
			[0 color LightBlue]
			[1 color Blue]
		}
		scale 2
		translate -1
	}
	pigment
	{
		bozo
		turbulence 0.65
		octaves 6
		omega 0.7
		lambda 2
		colour_map
		{
			[0.0 color rgb <0.85, 0.85, 0.85>]
			[0.1 color rgb <0.75, 0.75, 0.75>]
			[0.5 color rgbt <1, 1, 1, 1>]
			[1.0 color rgbt <1, 1, 1, 1>]
		}
		scale <0.08, 0.2, 0.08>
	}
}


