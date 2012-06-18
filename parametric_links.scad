// ********************	PARAMETRIZED LINK	***********************
//
//	Design by Daniel Gómez Lendínez & Olalla Bravo Conde
// www.thingiverse.com/dannynoc		www.thingiverse.com/olalla

// 	****** PARAMETERS *************
//
//	dtd: distance between axis
//	d: drills diameter
//	lh: length of the teeth hole
//	wh: width of the teeth hole
//	e: it controls the total width of the link
//	tl: tolerance for the own hole of the link so it engages well with the following link
//	th: tolerance of the teeth hole
//	w: width of the whole link


//	*********	MAIN BODY	**********
//	
//	It builds the basic rectangle with the hole for the tooth of the gear wheel

module main_body(dtd,lh,wh,a,w)
{
	difference()
	{
	 union()
	 {
		cube([dtd,a,w],center=true);
		rotate (a=[90,0,0]) translate ([-0.5*dtd,0,0]) cylinder (r=w/2, h=a,$fn=100, center=true);
	 	rotate (a=[90,0,0]) translate ([0.5*dtd,0,0]) cylinder (r=w/2, h=a,$fn=100, center=true);
	 }
	cube ([wh+w,lh+w,2*w], center=true);
}
}

//	******* DEFINITION OF THE LINK	***********

module link(dtd,d,lh,wh,e,tl,th)
{

	//	********* EXTRA PARAMETERS NEEDED TO DRAW THE LINK
	
	//Hole without tolerances (it refers to the indentation needed so that two consecutive links engage
	 u=lh+2*w;

	// Hole with tolerances
	ut=u+tl;
	
	//Teeth hole with tolerances
	lh=lh+2*th;
	wh=wh+2*th;	

	// Total width of the piece
	a=2*lh+4*e+tl+w;	

difference()
{
	union()
	{
	 main_body(dtd=dtd,w=w,a=a,lh=lh,wh=wh);
	// - - - - - - - - - - - - - - - - - - - - - 
		// Making the round parts of the teeth hole

		// Lateral cylinders
		rotate (a=[90,0,0]) translate ([(w+wh)/2,0,0]) cylinder (r=w/2, h=lh+w,$fn=100, center=true);
		rotate (a=[90,0,0]) translate ([-(w+wh)/2,0,0]) cylinder (r=w/2, h=lh+w,$fn=100, center=true);

		// Front cylinders
		rotate (a=[0,90,0]) translate([0,-(w+lh)/2,0]) cylinder(r=w/2,h=wh+w,$fn=100,center=true);
		rotate (a=[0,90,0]) translate([0,(w+lh)/2,0]) cylinder(r=w/2,h=wh+w,$fn=100,center=true);

		// Giving body under the round part
		translate([-(wh/2+w/4),0,-w/4]) cube([w/2,a,w/2],center=true);
		translate([(wh/2+w/4),0,-w/4]) cube([w/2,a,w/2],center=true);	
		translate([0,(lh/2+w/4),-w/4]) cube([wh+w,w/2,w/2],center=true);
		translate([0,-(lh/2+w/4),-w/4]) cube([wh+w,w/2,w/2],center=true);
	}
	
	 union()
		{
		// - - - - - - - - - - - - - - - - - - - - -
		// Perforating the main body 

		// Lateral holes -- in order to make front indentation
		translate ([-(0.5*dtd),(a+u)/4+a/2,0]) cube ([w+4*tl,(a-u)/2+a,2*w], center=true);
		translate ([-(0.5*dtd),-(a+u)/4-a/2,0]) cube ([w+4*tl,(a-u)/2+a,2*w], center=true);
		
		// Back hole
 		translate ([0.5*dtd,0,0]) cube ([w+2*tl,ut,2*w], center=true);

		// Drills for axis
		rotate (a=[90,0,0]) translate ([-0.5*dtd,0,0]) cylinder (r=d/2+tl/2, h=4*lh,$fn=100, center=true);
		rotate (a=[90,0,0]) translate ([0.5*dtd,0,0]) cylinder (r=d/2+tl/2, h=4*lh,$fn=100, center=true);

		//Difference to acotate the link laterally
  		translate([0,a,0]) cube([dtd,a,w],center=true);
   		translate([0,-a,0]) cube([dtd,a,w],center=true);

		//Difference to acotate the link in the upper and lower part
			translate([0,0,w/2+a/2]) cube([dtd+2*w,a,a],center=true);
			translate([0,0,-w/2-a/2]) cube([dtd+2*w,a,a],center=true);
	
		//Diference to acotate the link in the front and bottom part
			translate([dtd/2+w,0,0]) cube([w,a,a],center=true);
			translate([-(dtd/2+w),0,0]) cube([w,a,a],center=true);
				
	 }



	}
}

for (i=[0:2])
{
	translate([i*19.29,0,0]) link(dtd=19.29,d=3,lh=8,wh=3.9,e=2,tl=1,w=6,th=0.3);
}

//main_body(dtd=16,w=6,a=10,lh=2,wh=3);
