$fa=2; $fs=0.5;


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