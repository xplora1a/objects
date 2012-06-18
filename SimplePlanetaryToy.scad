include <./MCAD/involute_gears.scad>;
// Differential Planetary Gearset


fourgears();
//ring1();
//ring2();
//armature();
//assembly();

d1=60;// diameter of lower ring
t=4;// thickness of all gears
t1=1.2;// thickness of ring faces
b=0.25;// backlash
c=0.2;// clearance
pa=20;// pressure angle
s=0.4;// vertical clearance
td=0.8;// thickness of planet disk
pd=1.1;// planet disk diameter / pitch diameter
dp=0.85;// ring gear diameter / outside ring diameter

ns=10;// number of teeth on sun (lower)
np1=20;// number of teeth on lower planet

plug=2;
plugGapModifier=1.2;

//--------- Don't edit below here unless you know what you're doing.

nr1=ns+2*np1;// number of teeth on lower ring
pitch=nr1/(d1*dp);// diametral pitch of all gears

R1=(1+nr1/ns);// sun to planet-carrier ratio
Rp=(np1+ns)/np1;// planet to planet-carrier ratio
R=R1;
echo(str("na is : ",nr1));
echo(str("Gear Ratio is 1 : ",R1));

module assembly(){
color([0.5,0.5,0.5])ring1();
translate([0,0,0])rotate([0,0,180/ns+360*R*$t])
	color([1,0,0])sun();
rotate([0,0,360*R*$t])translate([(ns+np1)/pitch/2,0,0])rotate([0,0,-360*R*(1+Rp)*$t])
	color([0,0,1])planet();
rotate([0,0,120+360*R*$t])translate([(ns+np1)/pitch/2,0,0])rotate([0,0,-120-360*R*(1+Rp)*$t])
	color([0,0,1])planet();
rotate([0,0,-120+360*R*$t])translate([(ns+np1)/pitch/2,0,0])rotate([0,0,120-360*R*(1+Rp)*$t])
	color([0,0,1])planet();
rotate([0,0,360*R*$t])translate([(ns+np1)/pitch/2,0,0])	color([0,0,1])arm();
rotate([0,0,120+360*R*$t])translate([(ns+np1)/pitch/2,0,0])	color([0,0,1])arm();
rotate([0,0,-120+360*R*$t])translate([(ns+np1)/pitch/2,0,0])	color([0,0,1])arm();
}

module fourgears(){
	sun();
	for(i=[0,120,-120])
		rotate([0,0,i])translate([2*(ns+np1)/pitch/2,0,0])
			rotate([0,0,-i])planet();
}

module sun()
union(){
	gear(number_of_teeth=ns,
		diametral_pitch=pitch,
		gear_thickness=t,
		rim_thickness=t,
		hub_thickness=t,
		bore_diameter=0,
		backlash=b,
		clearance=c,
		pressure_angle=pa);
	cylinder(r=plug, h=t*3);
}

module planet()
union(){
	gear(number_of_teeth=np1,
		diametral_pitch=pitch,
		gear_thickness=t+s+td/2,
		rim_thickness=t+s+td/2,
		hub_thickness=t+s+td/2,
		bore_diameter=0,
		backlash=b,
		clearance=c,
		pressure_angle=pa);
                    cylinder(r=plug,t*2);

}

module arm()
translate([0,0,t])color([0,1,0])
	difference(){
		union(){
    			cylinder(r=4,t*.9);
			translate([t,0,t*.40])rotate([90,0,-120])cube([t/2,t/2,t*7]);
		}
  		translate([0,0,-t/2]) cylinder(r=plug*plugGapModifier,h=t*2);
	}

module armature() rotate([0,180,0]){
	rotate([0,0,360*R*$t])translate([(ns+np1)/pitch/2,0,0])	color([0,0,1])arm();
	rotate([0,0,120+360*R*$t])translate([(ns+np1)/pitch/2,0,0])	color([0,0,1])arm();
	rotate([0,0,-120+360*R*$t])translate([(ns+np1)/pitch/2,0,0])	color([0,0,1])arm();
}


module ring1() insidegear(nr1);

module insidegear(n)
//rotate([180,0,0])translate([0,0,-t])
difference(){
	cylinder(r=n/pitch/2/dp,h=t+t1);
//	translate([0,0,-0.5])cylinder(r=3,h=t+t1+1);
	translate([0,0,-.5])
	gear(number_of_teeth=n,
		diametral_pitch=pitch,
		gear_thickness=t+5,
		rim_thickness=t+5,
		hub_thickness=t+5,
		bore_diameter=0,
		backlash=-b,
		clearance=0,
		pressure_angle=pa);
}
