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
translate([0, -23, 0])
    resize([3, 29, height])
    cube(1);
translate([0, -23, 0])
    resize([62, 12, height])
    rounded_cube;
