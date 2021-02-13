$fa=1;
$fs=0.4;

include <MCAD/boxes.scad>

module hook() {
    polygon([
        [0,0],
        [-2.5, 0],
        [-2.5, -2],
        [-6, 0],
        [-6, 6],
        [-2.5, 8],
        [-2.5, 6],
        [1, 6]
    ]);
}

module platform() {
height=45;
linear_extrude(height=height) hook();
translate([1.5, -8.5, height/2])
    roundedBox(size=[3, 29, height], radius=1, sidesonly=true);
translate([33.5, -17, height/2])
    roundedBox(size=[67, 12, height], radius=1, sidesonly=true);
}

difference() {
    platform();
    translate([62/2 + 3, 12/2 - 21, 50/2 + 2])
        roundedBox(size=[62, 12, 50], radius=1);
}
