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
height=4;
linear_extrude(height=height) hook();
translate([0,-5,0]) resize([5,16,height]) cube(1);
translate([3.5, -8.5, 0])
    rotate_extrude(angle=90)
    translate([5.5, 0, 0])
    rotate([0, 0, 90])
    square([height, 2]);