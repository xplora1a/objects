$fa=2; $fs=0.5;


difference() {
	union() {
		difference() {
			cylinder(h = 63.7500000000, r = 27.0000000000);
			translate([0, 0, 2]) {
				cylinder(h = 63.7500000000, r = 25.5000000000);
			}
		}
		translate([25.9500000000, 0.0000000000, 57.7500000000]) {
			sphere(r = 2.4000000000);
		}
		translate([-12.9750000000, 22.4733592282, 57.7500000000]) {
			sphere(r = 2.4000000000);
		}
		translate([-12.9750000000, -22.4733592282, 57.7500000000]) {
			sphere(r = 2.4000000000);
		}
	}
	union() {
		translate([27.4500000000, 0.0000000000, 57.7500000000]) {
			sphere(r = 2.4000000000);
		}
		translate([-13.7250000000, 23.7723973339, 57.7500000000]) {
			sphere(r = 2.4000000000);
		}
		translate([-13.7250000000, -23.7723973339, 57.7500000000]) {
			sphere(r = 2.4000000000);
		}
	}
}
