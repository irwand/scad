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
    translate([6, 9, 30/2])
        roundedBox(size=[16, thickness, 30], radius=thickness/2, sidesonly=true);
}

module clamp() {
    union() {
        half_clamp();
        mirror([1, 0, 0]) half_clamp();
    }
}

module arm() {
    linear_extrude(height)
        polygon([
            [-21, 10],
            [-21, 7],
            [-16, 10]
        ]);
    translate([-21, -63, 0])
        rotate([0, 0, 90])
        rotate_extrude(angle=90)
        translate([63, 0, 0])
        square([10, height]);
}

module holder() {
    ht = 4;
    hh = 100;
    translate([-71, -69, hh/2])
        roundedBox(size=[30, ht, hh], radius=ht/2, sidesonly=true);
    
    hull() {
        translate([-98, -71, 0])
            linear_extrude(height)
            square([27, ht]);
        translate([-98, -96, 0])
            linear_extrude(height)
            square([10, 25]);
    }
    hull() {
        translate([-93, -96, 0])
            cylinder(hh, 5, 5);
        translate([-70, -70, 0])
            cylinder(hh, 2, 2);
    }
    hull() {
        translate([-84, -69, hh]) sphere(4);
        translate([-58, -69, hh]) sphere(4);
    }
}

clamp();
arm();
translate([4, 4, 0]) holder();