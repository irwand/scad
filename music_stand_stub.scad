$fa=1;
$fs=0.4;

difference() {
    linear_extrude(16)
        circle(27/2);
    linear_extrude(16)
        circle(6/2);
}


// =========================================
// this below is copied and modified from:
// https://www.thingiverse.com/thing:1079807
// specifically from Threaded_Ball_Socket.scad
// =========================================

include<threads/threads.scad>;
$fn=50;

module ball() {
    ballrad=7;//7
    threadod=20;//20
    threadlen=10;
    shaftrad=3.5;
    shaftrad2=5.5;//5
    taperlen=3;//min 3
    shaftlen=16;//min 10?

    difference()
    {
        union()
        {
            translate([0,0,threadlen+taperlen])cylinder(r1=shaftrad2,r2=shaftrad,h=shaftlen);
            difference()
            {
                translate([0,0,threadlen+taperlen+shaftlen+ballrad/2])sphere(r=ballrad);//+++++++++++++++++++++MAIN BALL SIZE
                translate([0,0,threadlen+taperlen+shaftlen-2])cylinder(r=0,r2=ballrad/2,h=ballrad*2);
                translate([-10,-10,threadlen+taperlen+shaftlen+ballrad*1.25])cube([20,20,4]);
            }
        }
        translate([0,0,ballrad*.86-2])cylinder(r1=shaftrad2-2,r2=shaftrad-2,h=taperlen+shaftlen+ballrad*2);
    }
}


translate([0, 2, 8])
    rotate([90, 0, 0])
    ball();
