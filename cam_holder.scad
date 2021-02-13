$fa=1;
$fs=0.4;

include <MCAD/boxes.scad>

height = 11;
thickness = 2;

module half_clamp() {
    translate([16, 3, 0])
        rotate_extrude(angle=90)
        translate([5, 0, 0])
        square([2, height]);
    translate([21, 0, 0])
        linear_extrude(height)
        intersection() {
            circle((2 + thickness)/2);
            translate([-((2 + thickness)/2), -(2 + thickness), 0])
               square((2 + thickness));
        }
    translate([0, 8, 0])
        linear_extrude(height)
        square([16, thickness]);
    translate([21, 0, 0])
        linear_extrude(height)
        square([thickness, 3]);
}

module clamp() {
    union() {
        half_clamp();
        mirror([1, 0, 0]) half_clamp();
    }
}

module arm() {
    translate([-16, -72, 0])
        rotate([0, 0, 90])
        rotate_extrude(angle=90)
        translate([80, 0, 0])
        square([thickness, height]);
}

module holder() {
    ht = 4;
    hh = 100;
    translate([-96, -72, 0])
        linear_extrude(height)
        square([36, ht]);
    translate([-71, -70, hh/2])
        roundedBox(size=[30, ht, hh], radius=ht/2, sidesonly=true);
    translate([-98, -102, 0])
        linear_extrude(height)
        square([ht, 30]);
    translate([-96, -106, 0])
        rotate_extrude()
        translate([2, 0, 0])
        square([ht, hh]);
}

clamp();
arm();
holder();