

use<PSF_3D_Lib.scad>

use<LCD-knob.scad>;
use<LCD-cover.scad>;
use<LCD-supports.scad>;

module lcd_frame(){
    translate([250/2-60,0,0]){

        translate([60,-39,49.5]) rotate([-135,0,0])LCD_cover();
        translate([5,-61,2])rotate([90,0,-90])LCD_support_l();
        translate([115,-61,2])rotate([90,0,-90])LCD_support_r();
        translate([123,-55,35]) rotate([45,0,0])LCD_knob();
    }
}
module control_frame(){
    difference(){
        union(){
            difference(){
                cube([250,210,40]);

                translate([250/2,210/2,40/2]) cube([230,190,42],center = true);
                translate([250/2,210/2,0]) cube([260,150,40],center = true);
                translate([250/2,210/2,0]) cube([190,230,30],center = true);
            }


                translate([0,0,30]) cube([250,30,10]);
                translate([250-30,0,30]) cube([30,210,10]);
                translate([0,210-30,30]) cube([250,30,10]);
                translate([0,0,30]) cube([30,210,10]);

        }

        translate ([3,210-15,-1]) cube([18,12,50]);
        translate ([250-3-18,210-15,-1]) cube([18,12,50]);

        //lcd left
        bolt_m3_cut(250/2-60,10,24,"BACK",10);
        bolt_m3_cut(250/2-60,10,24+11,"BACK",10);
        //lcd right
        bolt_m3_cut(250/2-60+110,10,24,"BACK",10);
        bolt_m3_cut(250/2-60+110,10,24+11,"BACK",10);

        //base
        bolt_m3_cut(40,20,30,"BOTTOM",15);
        bolt_m3_cut(250-40,20,30,"BOTTOM",15);
        bolt_m3_cut(40,210-20,30,"BOTTOM",15);
        bolt_m3_cut(250-40,210-20,30,"BOTTOM",15);

        bolt_m3_cut(20,40,30,"BOTTOM",15);
        bolt_m3_cut(250-20,40,30,"BOTTOM",15);
        bolt_m3_cut(20,210-40,30,"BOTTOM",15);
        bolt_m3_cut(250-20,210-40,30,"BOTTOM",15);

        // board base cut
        translate([200,45,30]) cube([40,120,5]);

        //fan base cut
        translate([162.5+3,20,15]) cube([25,20,30]);
        bolt_m3_cut(159+3,20,36,"BACK",15);
        bolt_m3_cut(159+3+32,20,36,"BACK",15);

    }
        // board base
        translate([150,50,35]){
        difference(){
            union(){
                translate([0,-30,0])cube([84.31,109.67+60,5]); //3.91, 4.1
                translate([4.1,3.91,-3]) cylinder(d=6,h=3,$fn=32);
                translate([84.31-4.1,3.91,-3])cylinder(d=6,h=3,$fn=32);
                translate([4.1,109.67-3.91,-3])cylinder(d=6,h=3,$fn=32);
                translate([84.31-4.1,109.67-3.91,-3])cylinder(d=6,h=3,$fn=32);
            }
            bolt_m3_cut(4.1,3.91,-10,"BOTTOM",15);
            bolt_m3_cut(84.31-4.1,3.91,-10,"BOTTOM",15);
            bolt_m3_cut(4.1,109.67-3.91,-10,"BOTTOM",15);
            bolt_m3_cut(84.31-4.1,109.67-3.91,-10,"BOTTOM",15);

            //fan base cut
            translate([5+3,-20,-25]) cube([40,40,40]);
        }
    }
}


module skr_v13_board(){
    translate([150,50,30]){
        difference(){
            cube([84.31,109.67,1.6]); //3.91, 4.1
            translate([4.1,3.91,0]) cylinder(d=3,h=10,center=true,$fn=32);
            translate([84.31-4.1,3.91,0])cylinder(d=3,h=10,center=true,$fn=32);
            translate([4.1,109.67-3.91,0])cylinder(d=3,h=10,center=true,$fn=32);
            translate([84.31-4.1,109.67-3.91,0])cylinder(d=3,h=10,center=true,$fn=32);
        }
    }
}


module control_frame_parts(){
    translate([-85+155+3,40,145])rotate([0,90,-90]) color("blue")import("40mmFan.stl");
    color("blue") skr_v13_board();
}


lcd_frame();
control_frame();
control_frame_parts();



