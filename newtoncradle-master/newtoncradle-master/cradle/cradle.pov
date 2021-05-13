#include "colors.inc"
#include "textures.inc"
#include "woods.inc"
#include "stones.inc"
#include "metals.inc"



/* Variables defining our newton's cradle */
#local ballRadius = 1;
/* Height of ball from ground */
#local ballHeight = 2 * ballRadius;
/* Height of stand from ground */
#local standHeight = ballRadius * 2 * 6; /* Stand about 6 times the diameter of a ball high */
/* Radius of the stand beams */
#local standRadius = ballRadius / 2;
/* Length of the upper horizontal bars that the balls hang from */
#local standLength = ballRadius * 2 * 8;
/* Width between the two upper horizontals bars */
#local standWidth =  ballRadius * 6;
#local stringRadius = ballRadius / 10;


#declare cradleDim = <standLength, standHeight, standWidth>;

/* START OF STAND DECLARATION */

#local HalfStand = union
{
	/* The top bars */
	cylinder
	{
		<0, standHeight, 0>, <standLength / 2, standHeight, 0>, standRadius
	}
	cylinder
	{
		<0, standHeight, standWidth>, <standLength / 2, standHeight, standWidth>, standRadius
	}

	/* The vertical side bars */
	cylinder
	{
		< standLength / 2, standHeight, 0>, < standLength / 2 + ballRadius, 0, 0>, standRadius
	}
	cylinder
	{
		<standLength / 2, standHeight, standWidth>, <standLength / 2 + 1, 0, standWidth>, standRadius
	}
	
	/* The horizontal base bar*/
	cylinder
	{
		<standLength / 2 + 1, 0, 0>, <standLength / 2 + 1, 0, standWidth>, standRadius
	}
}


#local FullStand = union
{
	object
	{
		HalfStand
		translate <0, 0, - (standWidth / 2)>
	}
	object
	{
		HalfStand
		translate <0, 0, - (standWidth / 2)>
		rotate <0, 180, 0>
	}
	texture
	{
		pigment
		{
			bozo
			colour_map
			{
				[ 0.0 rgb<0.15, 0.1, 0> ]
			        [ 1.0 rgb<0.4, 0.2, 0.05> ]
			}
		}	
		normal
		{
			wood 0.25 
			turbulence 0.1
		}
		finish
		{
			diffuse 0.4
		}
	}
}



/* START OF BALLBEARING DECLARATION */

#local BallBearing = sphere
{
	<0, 0, 0>, ballRadius
	texture
	{
		T_Silver_5E	
	}
}


#local stringHeight = standHeight - ballRadius - ballHeight - (standRadius / 2);

#local String = cylinder
{
		<0, 0, 0>, <0, stringHeight, standWidth / 2>, stringRadius
		texture
		{
			Tinny_Brass
			normal
			{
				planar 0.4 scale 0.2
			}
		}
}

#local BallAndStrings = union
{
	object
	{
		BallBearing
	}
	object
	{
		String
		translate <0, ballRadius, 0>
	}
	object
	{
		String
		rotate <0, 180, 0>
		translate< 0, ballRadius, 0>
	}
}


#declare Cradle = union
{
	object
	{
		FullStand
	}
	object
	{
		BallAndStrings
		/* This ball is on the end and needs to be rotated appropriately */
		#if ( clock < 0.5 )
			translate <0, -( stringHeight + ballRadius ), 0>
			rotate < 0, 0, 30 * -sin( clock * 2 * pi ) >
			translate <0, stringHeight + ballRadius, 0>
		#end
		translate < -5 * ballRadius, ballHeight, 0>
	}
	object
	{
		BallAndStrings
		translate < -3 * ballRadius, ballHeight, 0>
	}
	object
	{
		BallAndStrings
		translate < -1 * ballRadius, ballHeight, 0>
	}
	object
	{
		BallAndStrings
		translate < 1 * ballRadius, ballHeight, 0>
	}
	object
	{
		BallAndStrings
		translate < 3 * ballRadius, ballHeight, 0>
	}
	object
	{
		BallAndStrings
		/* This ball is on the end and needs to be rotated appropriately */
		#if( clock > 0.5 )
			translate <0, -( stringHeight + ballRadius ), 0>
			rotate < 0, 0, 30 * sin( (clock - 0.5 ) * 2 * pi )>
			translate <0, stringHeight + ballRadius, 0>
		#end
		translate < 5 * ballRadius, ballHeight, 0>
	}
	translate < 0, cradleDim.y / -2, 0>
}
