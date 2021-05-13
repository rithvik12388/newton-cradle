#newtoncradle
============

Newton's Cradle -- A short animation that I created for a Computer Graphics 200 assignment.

A 1080p video of my final animation can be found here:
https://www.youtube.com/watch?v=IT-r00vtNnk

This same video is 'newtonscradle.mp4' in the top directory of this repo.

##Rationale
The theme for our assignment was 'Over the Rainbow'. We were told that
despite obvious allusions to The Wizard of Oz, this theme was to
be interpreted however we wished.
I chose with my animation to attempt to capture a small part of what I
imagined Sir Isaac Newton's home might be like. This was easy to relate
to the theme because of his work in optics. 
One of my main goals was to attempt to make the scene as close to 
photorealistic as possible. This is the main reason that a model of Newton
himself is not included in the animation.
The very little amount of animation in the image was not a result of laziness. Rather it was part of my desire to create an animation that would
loop.


##Things that worked out
<ul>
	<li>Choosing a home setting was a good idea. I was sure that this would work out well before I started. The walls of the house effectively introduce a draw distance and require fewer objects to be modelled for a realistic scene. Additionally, making natural objects look realistic tends to require more effort due to their complexity.</li>

	<li>The idea behind the scene (a look into Newton's home) could be portrayed quite simply and effectively with povray. Newton's life can be easily symbolised through a set of discrete objects (cradle, prism, writings on calculus, apple tree) which are reasonably easy to model with povray. At the risk of sounding pretentious I would say that I didn't sacrifice much 'artistic value' by using povray.</li>

	<li>The procedurally generated tree looks surprisingly realistic. As stated before natural objects are difficult to model properly and I was surprised how well it came out. When I added the foilage to the skeleton it all came together great.</li>

	<li>The flame turned out very nicely. I spent a great deal of time getting it to look like an actual flame. It's not exactly the real deal but the reflection in the window especially looks great. The added flickering light was a nice touch and adds subtlety to the animation.</li>

	<li>I like the window. It just looks good.</li>
</ul>

##Things that didn't work out
<ul>
	<li>The tree is transparent for some reason. I have absolutely no idea why this is and I did not have the time to fix it before submission.  I believe it has something to do with the transparent glass as removing the window turns the tree opaque again.  </li>

	<li>The actual Newton's Cradle in the scene was not modelled too well. It was the first object that I modelled and I had learnt a great deal before I finished. I should have completely remodelled it and worked on the animation for longer.</li>

	<li>The beam of light coming from the prism is difficult to see.  Making it too brighter drew too much attention to it and even though it is part of the theme it was not supposed to be a focal point of the final animation. </li>

	<li>The textures are a little too perfect. I should have created a macro to layer a transparent noise texture over all objects and then coloured it to look a little like rust/erosion. Obviously old-timey stuff looked new when it was made but the manufacturing methods of the day would have made it more difficult to keep things pristine.</li>

	<li>The wall was supposed to be brick. I wanted to make a sort of uneven brick for the wall to make it look like the cottage was built out of stone. I ran out of time to do this properly so I went with stucco, which I'm fairly sure didn't exist at the time.</li>

	<li>Outside of the window is quite bare. I wanted to model both nice looking grass and some mountains but the mountains were giving me trouble and I ran out of time on this.</li>
</ul>

A lot of these are aesthetic concerns and I feel like I would have
eliminated them with another week or two of work on the scene.


##Folder structure
Each significant object in the final render has its own directory (e.g inkpot, desk, etc).
Each directory contains:
<ul>

	<li>The povray definition file for the object.  The objects are more or less centered at 0,0,0 and each object 'exports' variables containing its dimensions.  For example: tree/ contains tree.pov which defines the tree outside the window. The tree.pov file contains global variables 'treeDim' which is a vector in R3 containing the length of the tree in all three dimensions.  The tree's centre (roughly) will be at (0,0,0) so the top of the tree will be at treeDim.y / 2.</li>

	<li>A povray definition file containing a simple camera and light source.  This allows the objects in the scene to be viewed one at a time making it much easier to modify objects. The name of this file tends to be the same as the name of the object file with 'r' prefixed.  For example: The tree directory contains a file called 'rtree.pov' which can be used to render the tree on a plane with a simple light source.</li>

	<li>A povray configuration file.  This is always called povray.ini.  This is used in tandem with the above test povray file to allow the object to be rendered in isolation.</li>

	<li>A script file used to render the object by itself.  This has the same name as the object.</li>
</ul>
