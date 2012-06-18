module body(){
	difference(){
		import("tardis1to201.stl");
		translate([0,0,117])cube([100,100,25]);

		translate([8,8,5]) cube([48,48,135]);
//		translate([-8,-1.5,50]) cube([15,34,90],center=true);
	}
}

module top(){
	difference(){
		import("tardis1to201.stl");
//		translate([0,0,40.25])cube([100,100,80.6],center=true);
	}
}

//translate([-30,0,-0.5])
body();

//translate([30,0,-80.5])
//top();

//import("tardis1to201.stl");
