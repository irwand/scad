$fa=1;
$fs=0.4;

module half_cylinder(diameter, height) {
    linear_extrude(height)
        difference() {
            circle(diameter / 2);
            translate([0, -diameter/2, 0])
                square(diameter, center=true);
        }
}

module interlocking_snap_ring_helper(inner_diameter, thickness, height) {
    rotate_extrude(angle=180)
        translate([inner_diameter, 0, 0])
        square([thickness, height]);
    translate([inner_diameter + thickness, 0, 0])
        rotate([0, 0, 180])
        half_cylinder(thickness*2, height);
    translate([-(inner_diameter + (thickness*2)), 0, 0])
        rotate([0, 0, 180])
        half_cylinder(thickness*2, height);
    translate([-(inner_diameter + thickness), 0, 0])
        rotate([0, 0, 90])
        rotate_extrude(angle=90)
        translate([thickness, 0, 0])
        square([thickness, height]);
    translate([-(inner_diameter + thickness), thickness, 0])
        cube([thickness, thickness, height]);
}

module interlocking_snap_ring(inner_diameter, thickness, height) {
    difference() {
        interlocking_snap_ring_helper(inner_diameter, thickness, height);
        translate([-(inner_diameter + thickness), 0, 0])
            cube([thickness*2, thickness, height]);
    }
}

interlocking_snap_ring(38.5, 6, 20);
