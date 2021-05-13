#include "colors.inc"
#include "rand.inc"
#include "functions.inc"
#include "textures.inc"


#local appleDim = <10, 9, 10>;
#local leafDim = < 4, 10, 0.1 >;
#declare treeDim = <175, 200, 175>;

#macro makeBranch( height, baseRadius )
	isosurface
	{
		/* Maths */
		function
		{
			pow( x / ( baseRadius / sqrt( height ) ), 2 )  + pow( z /( baseRadius / sqrt( height ) ), 2 ) + y + f_noise_generator( x, y, z, 3) * baseRadius 
		}
		threshold height 
		max_gradient 500
		contained_by
		{
			box
			{
				<-baseRadius, 0, -baseRadius>, <baseRadius, height, baseRadius> 
			}
		}
	}
#end


#local Apple = union
{
	lathe
	{
		cubic_spline
		10, /* Number of points */
	        <0, 4>, <1, 3.5>, <2,3.25>, <3, 3>, <5, 7>, <3, 12>, /* Top of apple*/
		<0, 10>, <0, 4>, <0, 4>, <0, 4>/* Top hole */	
		texture
		{
			pigment
			{
				bozo
				colour_map
				{
					[0.0 rgb <1, 0.3, 0>]
					[0.3 rgb <1, 0.10, 0>]
					[0.5 rgb <0.7, 0, 0>]
					[0.7 rgb <0.8, 0, 0>]
					[0.9 rgb <0.9, 0, 0>]
					[1.0 rgb <1, 0, 0>] 
				}
				scale 6
			}
			normal
			{
				bozo 3
			}
			finish
			{
				phong 0.4
			}
		}
		texture
		{
			pigment
			{
				bumps
				turbulence 0.7
				colour_map
				{
					[0.0 rgbt <1, 0, 0, 0.95>]
					[1.0 rgbt <0.5, 0.5, 0.5, 0.95>]
				}
				scale 0.2
			}
		}
	}
	cylinder
	{
		0, <0, 2, 0>, 0.1
		texture
		{
			pigment
			{
				gradient y
				colour_map
				{
					[0.0 rgb <0.6, 0.1, 0>]
					[1.0 rgb <0.25, 0.5, 0>]
				}
				scale 2
			}
			normal
			{
				bumps 1
			}
		}
		rotate < 0, 0, 10 >
		translate <0, 11, 0>
	}
	translate <0, -5, 0>

}


#local Leaf = union
{
	disc
	{
		0, <0, 0, -1>, 4
		scale <0.5, 1, 1>
		texture
		{
			pigment
			{
				bozo
				turbulence 0.4
				colour_map
				{
					[0.0 rgb <0, 0.6, 0>]
					[1.0 rgb <0, 0.2, 0>]
				}
			}
			scale 1 
			normal
			{
				bumps 0.5 
				scale 0.05
			}
			finish
			{
				phong 0.1
			}
		}
	}
	cylinder
	{
		0, <0, 9, 0>, 0.1
		texture
		{
			pigment
			{
				color rgbt < 0.5, 0.5, 0.5, 0.7>
			}
		}
		translate <0, -5, 0>
	}
}



/* dim is the dimensions of the tree to make. y will be the height and
 the x value is used to determine the width */
/*smallestHeight is the height of the smallest branch. This is to provide
 a base case for the recursion. Once this case is reached a leaf will be
created and possibly an apple */
/* randSeed - a random seed stream */
/* recLevel - the level of recursion. Should start at 1. Used to determine
 the rotation required for the animation */
#macro makeTree( dim, smallestHeight, randSeed, recLevel )
	#local startHeight = 0.5; /* The height that the branches start up the tree */
	#local branchFrequency = 8; /* Higher the frequency the more branches */
	/* Min angle is the minimum angle of elevation (i.e from the horizontal) for
	a branch and max angle is the maximum angle of elevation */
	#local minAngle = 0;
	#local maxAngle = 90;
	union
	{
		object
		{
			makeBranch( dim.y, dim.x / 10 )
		}
		
		#local startY = dim.y * startHeight;

		#if ( dim.y > smallestHeight )
			#while ( startY < dim.y )
				object
				{
					makeTree( <dim.x / 2, dim.x / 2, dim.z / 2>, smallestHeight, randSeed, recLevel + 1 )
				/*	rotate < (90 - minAngle) - maxAngle * ( startY / ( dim.y * startHeight ) - 1 ), 0, 0>*/
					rotate < ( 2 - startY / ( dim.y * startHeight ) ) * 90, 0, 0 >
					rotate <0, rand( randSeed ) * 360, 0 >
					translate < 0, startY, 0 >
				}
				/* We want more branches on the main trunk without creating exponentially many small branches */
				#if (recLevel = 1)
					#local startY = startY + ( dim.y + 1 ) / (4 * branchFrequency ); /* The +1 for zeno's*/
				#else
					#local startY = startY + ( dim.y + 1 ) / branchFrequency; /* The +1 for zeno's*/
				#end

			#end
		#else
			/* Add leaves */
			object
			{
				Leaf
				translate <0, 10, 0> / 2
				rotate <90, 0, 0>
				rotate <0, rand( randSeed ) * 360, 0>
				translate <0, dim.y, 0>
			}
			/* Add apple to every 1/80 terminal branches */
			#if ( rand( randSeed ) <= (1/80) )
				object
				{
					Apple
					translate <0, -4.5, 0 > + <0, dim.y, 0>
				}
			#end

		#end
	}
#end


#declare Tree =
object
{
	makeTree( treeDim, treeDim.y / 100, seed(1), 1 )
	texture
	{
		pigment
		{
			bozo
			colour_map
			{
				[0.0 rgb <0.5, 0.35, 0.3>]
				[1.0 color Black]
			}
		}
		normal
		{
			wood 2
			scale 10
		}
	}
	translate <0, treeDim.y / -2, 0>
}
