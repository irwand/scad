module half_cylinder(diameter, height) {
    linear_extrude(height)
        difference() {
            circle(diameter / 2);
            translate([0, -diameter/2, 0])
                square(diameter, center=true);
        }
}

module interlocking_snap_ring_helper(inner_radius, thickness, height) {
    rotate_extrude(angle=180)
        translate([inner_radius, 0, 0])
        square([thickness, height]);
    translate([inner_radius + thickness*.75, 0, 0])
        rotate([0, 0, 180])
        half_cylinder(thickness*1.5, height);
    translate([-(inner_radius + (thickness*1.75)), 0, 0])
        rotate([0, 0, 180])
        half_cylinder(thickness*1.5, height);
    translate([-(inner_radius + thickness*.5), 0, 0])
        rotate([0, 0, 90])
        rotate_extrude(angle=90)
        translate([thickness, 0, 0])
        square([thickness, height]);
}

module interlocking_snap_ring(inner_diameter, thickness, height) {
    inner_radius = inner_diameter / 2;
    difference() {
        interlocking_snap_ring_helper(inner_radius, thickness, height);
        hull () {
            translate([-(inner_radius + thickness*.5), 0, 0])
                half_cylinder(thickness*2, height+2);
            cube([thickness, thickness, height+2]);
        }
    }
}
