$fa=1;
$fs=0.4;

nose_bridge_width = 40;
nose_bridge_height = 21;
nose_bridge_length = 10;
nose_expansion_percent = 20;
nose_to_spacer_length = 35;
nose_to_spacer_widening_percent = 60;
spacer_height = 35;
branch_point_to_tip_length = 25;
nose_clip_gap = 5;

thickness = 2;

_half_width = nose_bridge_width / 2;
_half_height = nose_bridge_height / 2;
_expansion = 1 + (nose_expansion_percent / 100);
_spacer_expansion = 1 + (nose_to_spacer_widening_percent / 100);

module _sp() { sphere(d=thickness); }
module _br() { resize([thickness*4, thickness*4, thickness*2]) _sp(); }
module _ov() { resize([thickness*2, thickness*2, thickness/2]) _sp(); }

module half_model() {
    nose_curve_top = [ for (t=[0:10:160]) [t*_half_width/180, 0, (cos(t)*_half_height)+_half_height]];
    nose_curve_bottom = [ for (t=[0:10:160]) [t*_half_width*_expansion/180, nose_bridge_length, (cos(t)*_half_height*_expansion)+_half_height*_expansion]];

    for (i=[0:len(nose_curve_top)-2]) {
        hull() {
            translate(nose_curve_top[i]) _sp();
            translate(nose_curve_bottom[i]) _sp();
            translate(nose_curve_top[i+1]) _sp();
            translate(nose_curve_bottom[i+1]) _sp();
        }
    }

    nose_clip_top = [ for (t=[110:10:160]) [(t*_half_width/180)+nose_clip_gap, 0, (cos(t)*_half_height)+_half_height]];
    nose_clip_bottom = [ for (t=[110:10:160]) [(t*_half_width*_expansion/180)+nose_clip_gap, nose_bridge_length, (cos(t)*_half_height*_expansion)+_half_height*_expansion]];

    for (i=[0:len(nose_clip_top)-2]) {
        hull() {
            translate(nose_clip_top[i]) _sp();
            translate(nose_clip_bottom[i]) _sp();
            translate(nose_clip_top[i+1]) _sp();
            translate(nose_clip_bottom[i+1]) _sp();
        }
    }

    joining = 6;
    delta = len(nose_curve_top) - joining;
    for (i=[0:joining-2]) {
        hull() {
            translate(nose_curve_top[delta+i]) _sp();
            translate(nose_curve_top[delta+i+1]) _sp();
            translate(nose_clip_top[i]) _sp();
            translate(nose_clip_top[i+1]) _sp();
        }
    }

    hull () {
        translate(nose_clip_top[len(nose_clip_top)-1]) _sp();
        translate([6, 0, 0])
        translate(nose_clip_top[len(nose_clip_top)-1]) _sp();
        translate(nose_clip_bottom[len(nose_clip_top)-1]) _sp();
        translate([6, 0, 0])
        translate(nose_clip_bottom[len(nose_clip_top)-1]) _sp();
    }

    bottom_edge = nose_curve_bottom[len(nose_curve_top)-1];
    branch_point = [bottom_edge[0]*_spacer_expansion, nose_to_spacer_length, 0];
    hull() {
        translate(nose_curve_bottom[len(nose_curve_top)-1]) _sp();
        translate(nose_curve_bottom[len(nose_curve_top)-2]) _sp();
        translate(branch_point) _br();
    }

    spacer_curve = [ for (t=[90:-10:0]) [t*branch_point[0]/90, branch_point[1]+((90-t)*branch_point_to_tip_length/90), (cos(t)*spacer_height)]];
    for (i=[0:len(spacer_curve)-2]) {
        hull() {
            translate(spacer_curve[i]) _ov();
            translate(spacer_curve[i+1]) _ov();
        }
    }
}

// This below is so we have good flat initial layer on 3D printer
difference() {
    union() {
        half_model();
        mirror([1, 0, 0]) half_model();
    }
    translate([0, 0, -100]) cube(200, center=true);
}
