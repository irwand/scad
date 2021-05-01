$fa=1;
$fs=0.4;

// calculated using tennis balls ~68mm
tennis_ball_radius = 34;
divider_radius = 4;
divider_distance = 67;
divider_length = 200-divider_radius;
handle_length = 17;

module cyl(h) {
    cylinder(h=h, r=divider_radius);
}

module chop_angle(a, pos) {
    difference() {
        children();
        translate(pos)
            rotate([0, 0, a])
            translate([-divider_radius*2, 0, -divider_radius*2])
            cube(divider_radius*4);
    }
}

module carrier() {
    chop_angle(-135, [0, -divider_length, 0]) {
        rotate([90, 0, 0]) cyl(divider_length+divider_radius);
    }
    translate([divider_distance, 0, 0]) rotate([90, 0, 0]) cyl(divider_length);
    translate([divider_distance*2, 0, 0]) rotate([90, 0, 0]) cyl(divider_length);
    chop_angle(135, [divider_distance*3, -divider_length, 0]) {
        translate([divider_distance*3, 0, 0]) rotate([90, 0, 0]) cyl(divider_length+divider_radius);
    }
    rotate([0, 90, 0]) cyl(divider_distance*3);
    chop_angle(45, [0, -divider_length, 0]) {
        chop_angle(-45, [divider_distance*3, -divider_length, 0]) {
            translate([-divider_radius, -divider_length, 0]) rotate([0, 90, 0]) cyl(divider_distance*3+divider_radius*2);
        }
    }

    chop_angle(-45, [0, handle_length-divider_radius, 0]) {
        translate([0, handle_length, 0]) rotate([90, 0, 0]) cyl(handle_length);
    }
    chop_angle(45, [divider_distance*3, handle_length-divider_radius, 0]) {
        translate([divider_distance*3, handle_length, 0]) rotate([90, 0, 0]) cyl(handle_length);
    }
    chop_angle(225, [divider_distance*3, handle_length-divider_radius, 0]) {
        chop_angle(135, [0, handle_length-divider_radius, 0]) {
            translate([-divider_radius, handle_length-divider_radius, 0]) rotate([0, 90, 0]) cyl(divider_distance*3+divider_radius*2);
        }
    }

    rotate([0, 90, 0])
        rotate([0, 0, 120])
        translate([-tennis_ball_radius-1.5, 0, 0])
        rotate_extrude(angle=45)
        translate([tennis_ball_radius, 0, 0])
        square([3, divider_distance*3]);
}

// slice bottom for better print adhesion
difference() {
    translate([0, 0, divider_radius*3/4])
        carrier();
    translate([-divider_radius, -200, -5])
        cube([220, 220, 5]);
}
