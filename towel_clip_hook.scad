$fa=1;
$fs=0.4;

include <MCAD/boxes.scad>

diamond_mesh_width = 50;
rounded_radius = 2;
thickness = 8;
width = 8;
neck = 8;
clip_length = 30;
teeth_to_clip_edge = 5;
teeth_length = 8;
lower_jaw_offset = 2.2;
clip_radius = 3;
lower_jaw_extension = 5;

module _sp() { translate([0, 0, rounded_radius]) sphere(r=rounded_radius); }

module rounded_square( width, r_c ) {
	hull() {
		translate( [r_c, r_c, 0] ) circle( r_c );
		translate( [r_c, width - r_c, 0 ] ) circle( r_c );
		translate( [width - r_c, r_c, 0] ) circle( r_c );
		translate( [width - r_c, width - r_c, 0] ) circle( r_c );
	}
}

module half_cylinder(r) {
    linear_extrude(thickness)
        difference() {
            circle(r);
            translate([0, -r, 0])
                square(r*2, center=true);
        }
}

module myOffsetRoundBox(size) {
    translate([(size[0]+rounded_radius)/2 - rounded_radius, size[1]/2, size[2]/2])
        roundedBox(size=[size[0]+rounded_radius, size[1], size[2]], radius=rounded_radius);
}

module lower_jaw(teeth) {
    teeth_lower = concat(teeth, [[clip_length+lower_jaw_extension+clip_radius, 0], [clip_length+lower_jaw_extension+clip_radius, -width], [0, -width]]);
    linear_extrude(thickness) polygon(teeth_lower);
    translate([clip_length+clip_radius, -width, 0])
        cube([lower_jaw_extension, width+lower_jaw_offset+clip_radius*2, thickness]);
    translate([clip_length+clip_radius, clip_radius+lower_jaw_offset, 0])
        half_cylinder(clip_radius);
}

module half_clip() {
    translate([0, width+rounded_radius*2, 0])
        myOffsetRoundBox([width/2, width+rounded_radius*4, thickness]);
    teeth = [ for (t=[0:10:540]) [t*(clip_length-teeth_to_clip_edge)/540, cos(t)*(teeth_length/2)+(teeth_length/2)]];
    teeth_clip = concat(teeth, [[clip_length, 0], [clip_length, teeth_length+width], [0, teeth_length+width]]);
    linear_extrude(thickness) polygon(teeth_clip);
    translate([clip_length, clip_radius, 0])
        rotate([0, 0, 180])
        half_cylinder(clip_radius);

    translate([0, -lower_jaw_offset-width*2, 0]) lower_jaw(teeth);
}

union() {
    translate([0, diamond_mesh_width-5])
        rotate([0, 0, -90])
        rotate_extrude(angle=300)
        translate([diamond_mesh_width/2-thickness, 0, 0])
        rounded_square(thickness, rounded_radius);
    half_clip();
    mirror([1, 0, 0]) half_clip();
}
