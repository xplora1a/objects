h=50;
w=h/2;
th=h/26;
th1=th/(4/3);
th2=th/4;

//base
module base() {
	translate([-(w/2),-(w/2),0]) cube([w,w,th]);
	for (rot=[0:3])
		rotate(rot*90)
		union() {
			translate([(w/2)-th,(w/2)-th,th1]) cube([th,th,h]) ;
			difference(){
				translate([-(w/2),-(w/2),0]) translate([th1,th2,th1]) cube([w-2*th1,th1,h]);
				for (x2=[2*th1 : 8*th1 : 26*th1])
					for (x1=[th+th2, 9*th1])
						translate([-(w/2),-(w/2),0]) translate([x1,th2,x2]) cube([(w/2)-(th+th1),th2+0.01,(w/2)-(th+th2)]);
			}
		}
	}


//top
module top(){
	translate([-w/2,-w/2,0]) cube([w,w,th]);
	translate([-w/2,-w/2,th])
		polyhedron(points=[[w/2,w/2,2*th],[0,0,0],[w,0,0],[w,w,0],[0,w,0]],
		triangles=[[1,2,3],[3,1,4],[1,0,2],[2,0,3],[3,0,4],[4,0,1]]);
	translate([0,0,2*th]) cylinder(2*th,th,th1, centre=true);
	}

//color("blue")
translate([w,0,0]) base();
translate([-w,0,0]) top();
 