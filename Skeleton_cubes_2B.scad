module cube_skeleton(length, inner) 
{
 difference() {
  cube(length, true);
  cube(size = [length+0.01, inner, inner], center = true);
  cube(size = [inner, length+0.01, inner], center = true);
  cube(size = [inner, inner, length+0.01], center = true);
  }
}

height=50;
cubelen=height/sqrt(3);
cubein=cubelen*0.8;
translate([0,0,height/2]) union()
{
   translate(v = [0,0,-(height/2)]) cylinder(h=height*0.11, r=cubelen/2, $fn=70);

   rotate(109.5/2, [1,1,0])
	union()
	{
	    cube_skeleton(cubelen,cubein);
	    rotate(60, [1,1,1]) cube_skeleton(cubelen,cubein);
	    rotate(60, [1,-1,-1]) cube_skeleton(cubelen,cubein);
	    rotate(60, [-1,1,-1]) cube_skeleton(cubelen,cubein);
	    rotate(60, [-1,-1,1]) cube_skeleton(cubelen,cubein);
	}
}
