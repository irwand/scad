$fa=1;
$fs=0.4;

include <interlocking_snap_ring.scad>
interlocking_snap_ring(39, 4, 20);

// =========================================
// this below is copied and modified from:
// https://www.thingiverse.com/thing:1079807
// specifically from Threaded_Ball_Socket.scad
// =========================================

include <threads/threads.scad>;
$fn=50;

ballrad=7;//7
threadod=20;//20
threadlen=10;
shaftrad=3.5;
shaftrad2=7;//modified, original: 5
taperlen=3;//min 3
shaftlen=116;//min 10?

module socket() {
    difference()
    {
        union()
        {
            difference() // balsocket
            {
                metric_thread (diameter=threadod, pitch=4, length=threadlen, thread_size=2, groove=true);
                translate([0,0,-2])sphere(r=ballrad*1.02); //+++++++++++++++++++++MAIN SOCKET SIZE
            }
            translate([0,0,threadlen])cylinder(r1=threadod/2-2,r2=shaftrad2,h=taperlen);
            translate([0,0,threadlen+taperlen])cylinder(r1=shaftrad2,r2=shaftrad2,h=shaftlen);
        }
        translate([0,0,ballrad*.86-2])cylinder(r1=shaftrad2-2,r2=shaftrad-2,h=taperlen+shaftlen+ballrad*2);
    }
}

translate([0, (39/2)+30+100, 10])
    rotate([90, 0, 0])
    socket();
