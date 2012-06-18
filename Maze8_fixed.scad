$fa=2; $fs=0.5;
// maze8_fixed.scad - hand edited by Scott Elliott
// This file was originally output by Wizard23's Python script "mazebox_clean2_stable.py"
// I made the following tweaks to avoid errors in OpenSCAD:
//
//   1. The first polyhedron is prefixed "translate([0,0,-0.001]) " to avoid manifold errors (bad polygons) in the bottom surface.
//
//   2. The second polyhedron was replaced with a copy-and-paste of the first polyhedron, with "scale([0.94,0.94,1.0]) " to cut it out of the center.
//
difference() {
	union() {
		cylinder(h = 9, r = 27.0000000000);
	}
	intersection() {
		translate([0, 0, 2]) {
			cylinder(h = 76.7250000000, r = 28.0000000000);
		}
	}
}