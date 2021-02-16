$fa=1;
$fs=0.4;

module hook() {
    polygon([
        [0,0],
        [-2.5, 0],
        [-2.5, -2],
        [-6, 0],
        [-6, 6],
        [-2.5, 8],
        [-2.5, 6],
        [0, 6]
    ]);
}
height=16;
linear_extrude(height=height) hook();

difference() {
    hull() {
        translate([0,-10,0])
            cube([4, 25, height]);
        translate([8, 15, 8])
            rotate([90, 0, 0])
            rotate_extrude()
            translate([4, 0, 0])
            square([4, 25]);
    }
    translate([8, 17, 8])
        rotate([90, 0, 0])
        cylinder(30, 4.04, 4.04);
}