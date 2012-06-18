
//	PARAMETRIC GEAR WHEELS

//		Parameters
//
//	re= external radius
//	ri= internal radius
//	n=number of gears the wheel has
//	d=parameter to control the separation between gears
//	h=height of the wheel

module gear_wheel(re,ri,n,d)
{
	// Angle difference between middle points of gears
	am=360/n;

	// Angle difference between middle and ending points of gears
	ad=360/((d+1)*n*4);

	// Drawing gears

	for (i=[0:n-1])
	 linear_extrude(height = h, center = true, convexity = 10, twist = 0)
	 polygon(
		points=[
			[0,0],
			[ri*cos(am*i-2*ad),ri*sin(am*i-2*ad)],
			[re*cos(am*i-ad),re*sin(am*i-ad)],
			[re*cos(am*i),re*sin(am*i)],
			[re*cos(am*i+ad),re*sin(am*i+ad)],
			[ri*cos(am*i+2*ad),ri*sin(am*i+2*ad)]
			 ],
		paths=[[0,1,2,3,4,5]]);

	// Drawing internal circle

	cylinder(r=ri,h=h,center=true,$fn=100);








}


// example of use

difference()
{
	gear_wheel(re=30,ri=25,n=6,d=3,h=8);

	union(){
//-- Carved cicle for the Futaba plate
    translate([0,0,10]) cylinder(r=21.5/2, center=true,h=20,$fn=100);

    //-- Carved circle por the Futaba shart
    cylinder(center=true, h=30, r=4.2,$fn=100);
}}