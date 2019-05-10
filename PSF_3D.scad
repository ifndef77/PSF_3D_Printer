
// PSF 3D BASE
// build volume
// x =
// y = 170;
// x =

include<PSF_3D_define.scad>
include<PSF_3D_lib.scad>
include<PSF_3D_timing_belts.scad>
include<PSF_3D_bed.scad>

use<prusa_y-belt-holder.scad>
use<e3d_v6_all_metall_hotend.scad>



%frame();
%frame_parts();
%bed();

translate([0,0,0]){
z_carriage();
z_carriage_part();

x_carriage();
x_carriage_part();
}

module x_carriage(){
}

module x_carriage_part(){
	
	translate([size_x/2,size_y/2+x_load_offset_y+15,120]) rotate([0,90,0]) lm8uu(50);
	translate([size_x/2,size_y/2-x_load_offset_y+15,120]) rotate([0,90,0]) lm8uu(50);
	
	translate([size_x/2,size_y/2+15,145]) rotate([180,0,180]) color("blue")e3d();
}


module z_carriage(){
	
	module tie_hole(x,y,z){
		translate([x,y,z]) rotate([0,0,0]) difference(){
			cylinder(d=25,h=4,$fn=32,center=true);
			cylinder(d=17,h=5,$fn=32,center=true);
			}
	}
	
	module base(){
		difference(){
			union(){
				translate([0-3,size_y/2,100]) cube([20,110,60],center=true);
				translate([2,size_y/2+z_load_offset_y,100-10]) cube([30,20,40],center=true);
				translate([2,size_y/2-z_load_offset_y,100-10]) cube([30,20,40],center=true);
				translate([11,size_y/2-6,100]) rotate([-90,0,180]) translate([0,0,-37]) y_belt_holder2();
			}
			tie_hole(10,size_y/2+z_load_offset_y,100+5);
			tie_hole(10,size_y/2+z_load_offset_y,100-25);
			tie_hole(10,size_y/2-z_load_offset_y,100+5);
			tie_hole(10,size_y/2-z_load_offset_y,100-25);
		}
		
	}
	
	
	
	base();
	translate([size_x,0,0]) mirror([1,0,0]) base();
	
	
	
}

module z_carriage_part(){
	
	// load
	x_load(0-20,size_y/2+x_load_offset_y+15,120);
	x_load(0-20,size_y/2-x_load_offset_y+15,120);
	
	// z bearing
	translate([10,size_y/2+z_load_offset_y,100-10]) rotate([0,0,0]) lm8uu(40);
	translate([10,size_y/2-z_load_offset_y,100-10]) rotate([0,0,0]) lm8uu(40);
	
	translate([size_x-10,size_y/2+z_load_offset_y,100-10]) rotate([0,0,0]) lm8uu(40);
	translate([size_x-10,size_y/2-z_load_offset_y,100-10]) rotate([0,0,0]) lm8uu(40);
	
}

module x_load(x,y,z){
	
	translate ([x,y,z]) rotate([0,90,0]){
		load(load_l);
		//translate ([0,0,size_y/2+30]) lm8uu();
		//translate ([0,0,size_y/2-30]) lm8uu();
		//translate ([9,-8,ly_b_offset1]) rotate([-90,0,45]) bolt_m3(5);
		//translate ([9,-8,ly_b_offset2]) rotate([-90,0,45]) bolt_m3(5);
		
	}
	
}


module frame (){
	intersection(){
		union(){
			frame_left();
			translate([size_x,0,0]) mirror([1,0,0]) frame_left();
			frame_front();
			frame_back();
		}
		hull(){
			translate([9.5,9.5,-1]) cylinder(d=20,h=400,$fn=32);
			translate([9.5,size_y-9.5,-1]) cylinder(d=20,h=400,$fn=32);
			translate([size_x-9.5,size_y-9.5,-1]) cylinder(d=20,h=400,$fn=32);
			translate([size_x-9.5,9.5,-1]) cylinder(d=20,h=400,$fn=32);
		}
	}	
}


module frame_parts(){
	
	
	y_load(y_load_offset_x,y_load_offset_z);
	y_pully(y_belt_center,20,21);
	y_motor(y_belt_center + 15,size_y-42/2 - base_y_t,42/2);
	
	//y_belt(y_belt_center,20,21,size_y-47,250);
	
	module left_side(){
		z_load(z_load_offset_x,size_y/2+z_load_offset_y,z_load_offset_z);
		z_load(z_load_offset_x,size_y/2-z_load_offset_y,z_load_offset_z);
		z_pully(z_pully_x,z_pully_y,z_pully_z);
		z_motor(base_x_t,z_pully_y,42/2);
		
		//z_belt(z_pully_x,z_pully_y,42/2,304);
	}
	
	left_side();
	translate([size_x,0,0]) mirror([1,0,0]) left_side();
}




module frame_left(){
	difference(){
		union(){
			cube([base_x_t,size_y,base_z_t]);
			cube([top_x_t,top_y_t,size_z]);
			
			cube([50,size_y,10]);
			
			translate([0,size_y-top_y_t,0]) cube([top_x_t,top_y_t,size_z]);
			translate([0,0,size_z-top_z_t]) cube([top_x_t,size_y,top_z_t]);
	
			//translate([0,size_y/3,0]) cube([top_x_t,top_y_t,size_z]); //중간기둥		
			//translate([0,0,size_z-87]) rotate([-45,0,0]) cube([top_x_t,top_y_t,120]); //보조 45도
			//translate([0,size_y-120,30]) rotate([-45,0,0]) cube([top_x_t,top_y_t,150]); //보조 45도 
			
		}
		
		// z load
		translate([z_load_offset_x,size_y/2+z_load_offset_y,z_load_offset_z]) rotate([0,0,0]) cylinder(d=8.1,h=load_l+1,$fn=32); //z load
		bolt_m3_cut(top_x_t,size_y/2+z_load_offset_y,size_z-5,"RIGHT",7);
		bolt_m3_cut(top_x_t,size_y/2+z_load_offset_y,42-5,"RIGHT",7);
		
		translate([z_load_offset_x,size_y/2-z_load_offset_y,z_load_offset_z]) rotate([0,0,0]) cylinder(d=8.1,h=load_l+1,$fn=32); //z load
		bolt_m3_cut(top_x_t,size_y/2-z_load_offset_y,size_z-5,"RIGHT",7);
		bolt_m3_cut(top_x_t,size_y/2-z_load_offset_y,42-5,"RIGHT",7);
		
		// z motor
		translate([7,z_pully_y-11,21]) cube([10,22,50]);
		translate([base_x_t,z_pully_y-21.5,0-0.5]) cube([40,43,43]);
		translate([base_x_t+20,z_pully_y-31,-0.5]) cube([10,10,43]);
		translate([base_x_t+0.5,z_pully_y,21]) rotate([0,-90,0]) cylinder(d=23,h=50,$fn=32);
		
		bolt_m3_cut(17,z_pully_y-15.5,21+15.5,"LEFT",12);
		bolt_m3_cut(17,z_pully_y-15.5,21-15.5,"LEFT",12);
		bolt_m3_cut(17,z_pully_y+15.5,21-15.5,"LEFT",12);
		bolt_m3_cut(17,z_pully_y+15.5,21+15.5,"LEFT",12);
		
		// z pully
		translate([z_pully_x -5,z_pully_y-10,z_pully_z-25]) cube([10,20,50]);
		bolt_m3_cut(top_x_t,z_pully_y,size_z-10,"RIGHT",20+0.5);
	}
	
	
}



module frame_front(){
	difference(){
		union(){
			cube([size_x,base_y_t,base_z_t]);
			cube([size_x,40,10]);
			translate([y_belt_center-15,0,0]) cube([30,30,31]);
		}
		
		//y pully
		translate([y_belt_center-5,10,10]) cube([10,50,50]);
		bolt_m3_cut(y_belt_center+13,20,21,"RIGHT",27);
		
		//y load
		translate([y_load_offset_x,-0.5, y_load_offset_z]) rotate([-90,0,0]) cylinder(d=8.1,h=load_l+1,$fn=32);
		translate([size_x-y_load_offset_x,-0.5, y_load_offset_z]) rotate([-90,0,0]) cylinder(d=8.1,h=load_l+1,$fn=32);
		
		bolt_m3_cut(y_load_offset_x+9,5,42-1,"TOP_R45",6);
		bolt_m3_cut(size_x-y_load_offset_x-9,5,42-1,"TOP_L45",6);
		
	}
	

	translate([0,0,size_z-top_z_t*2]) cube([size_x,top_y_t,top_z_t*2]);
	//translate([0,size_y/3*2,size_z-top_z_t]) cube([size_x,top_y_t,top_z_t]); //중간 
	translate([0,size_y/3*2,0]) cube([size_x,top_y_t,10]);
	
}



module frame_back(){
	
	difference(){
		union(){
			translate([0,size_y-base_y_t,0]) cube([size_x,base_y_t,base_z_t]);
			translate([0,size_y-40,0]) cube([size_x,40,10]);
			
			
			translate([0,size_y-top_y_t,size_z-top_z_t*2]) cube([size_x,top_y_t,top_z_t*2]);
			
			translate([y_belt_center+15-10,size_y-52,0]) cube([10,52,42]);
			
			//translate([0,z_load_offset_y+10,size_z-top_z_t]) cube([size_x,top_y_t,top_z_t]);
			//translate([y_belt_center+2.5,size_y-11,-5])rotate([0,0,180])mirror([1,0,0]) holder();
		}
		translate([0,0,-30]) cube([300,300,30]);
		
		//y load
		translate([y_load_offset_x,-0.5, y_load_offset_z]) rotate([-90,0,0]) cylinder(d=8.1,h=load_l+1,$fn=32);
		translate([size_x-y_load_offset_x,-0.5, y_load_offset_z]) rotate([-90,0,0]) cylinder(d=8.1,h=load_l+1,$fn=32);
		
		bolt_m3_cut(y_load_offset_x+9,size_y-5,42-1,"TOP_R45",6);
		bolt_m3_cut(size_x-y_load_offset_x-9,size_y-5,42-1,"TOP_L45",6);
		
		
		//y motor
		translate([y_belt_center+15,size_y-10-42,0]) cube([40,42,42]);
		translate([y_belt_center+15+0.5,size_y-10-21,21]) rotate([0,-90,0]) cylinder(d=23, h=20, $fn=32);
		
		translate([y_belt_center+15+0.5-20,size_y-10-43,21-11]) cube([20,23,40]);
		
		
		bolt_m3_cut(y_belt_center+5,size_y-10-21-15.5,21+15.5,"LEFT",10);
		bolt_m3_cut(y_belt_center+5,size_y-10-21+15.5,21+15.5,"LEFT",10);
		bolt_m3_cut(y_belt_center+5,size_y-10-21-15.5,21-15.5,"LEFT",10);
		

	}
}


//----------------------------------------------
// parts
//--------------------------------------

module y_load(x,z){
	translate ([x,0, z]) rotate([-90,0,0]){
		load(load_l);
		//translate ([0,0,size_y/2+30]) lm8uu();
		//translate ([0,0,size_y/2-30]) lm8uu();
		translate ([9,-8,ly_b_offset1]) rotate([-90,0,45]) bolt_m3(5);
		translate ([9,-8,ly_b_offset2]) rotate([-90,0,45]) bolt_m3(5);
		
	}
	translate ([size_x - x,0, z]) rotate([-90,0,0]){
		load(load_l);
		//translate ([0,0,size_y/2+30]) lm8uu();
		//translate ([0,0,size_y/2-30]) lm8uu();
		translate ([-9,-8,ly_b_offset1]) rotate([-90,0,-45]) bolt_m3(5);
		translate ([-9,-8,ly_b_offset2]) rotate([-90,0,-45]) bolt_m3(5);
	}
}

module y_pully(x,y,z){
	translate ([x,y,z]) rotate ([0,90,0]){
		i_pully();
		translate ([0,0,+10+2.5]) rotate([0,180,0]) bolt_m3(20);
	}
}

module y_motor(x,y,z){
	translate ([x,y,z]) rotate([0,-90,0]){
		stepper_motor(motor_l);
		translate ([0,0,15]) rotate([0,0,0]) t_pully(5);
		
		translate ([15.5,15.5,10]) rotate([0,180,0]) bolt_m3(10);
		translate ([-15.5,-15.5,10]) rotate([0,180,0]) bolt_m3(10);
	
	}
}

module y_belt(x=139,y=20,z=15,l=250){
	
	translate([x,y,z-6])rotate([90,0,90])color("aquamarine") {
		belt_len(tGT2_2,6, l);
		translate([l,12,0]) rotate([0,0,180]) belt_len(tGT2_2,6,l);
		translate([ 0,12,0]) rotate([0,0,180]) belt_angle(tGT2_2,6,6,180);
		translate([l,0,0]) rotate([0,0,0]) belt_angle(tGT2_2,6,6,180);
	}
}



module z_load (x,y,z){
	translate([x,y,z]) {
		rotate([0,0,0]) load(load_l);
		
		//translate ([0,0,100]) lm8uu();
		//translate ([0,0,130]) lm8uu();
		
		translate ([-x+24,0,lz_b_offset1]) rotate([0,-90,0]) bolt_m3(5);
		translate ([-x+24,0,lz_b_offset2]) rotate([0,-90,0]) bolt_m3(8);
	}
}


module z_pully (x,y,z){
	translate([x,y,z]){
		rotate([0,90,0]){
			i_pully();
			translate ([0,0,+7+5]) rotate([0,180,0]) bolt_m3(20);
		}
	}
}


module z_motor(x,y,z){
	translate ([x,y,z]) rotate([0,-90,0]){
		stepper_motor(motor_l);
		translate ([0,0,15]) rotate([0,0,0]) t_pully(5);
		translate ([15.5,15.5,10]) rotate([0,180,0]) bolt_m3(10);
		translate ([-15.5,15.5,10]) rotate([0,180,0]) bolt_m3(10);
		translate ([15.5,-15.5,10]) rotate([0,180,0]) bolt_m3(10);
		translate ([-15.5,-15.5,10]) rotate([0,180,0]) bolt_m3(10);
	
	}
}


module z_belt(x=12,y=140-6,z=15-3,l=290){
	translate([x,y-6,z])rotate([0,-90,0])color("aquamarine") {
		belt_len(tGT2_2,6, l);
		translate([l,12,0]) rotate([0,0,180]) belt_len(tGT2_2,6,l);
		translate([ 0,12,0]) rotate([0,0,180]) belt_angle(tGT2_2,6,6,180);
		translate([l,0,0]) rotate([0,0,0]) belt_angle(tGT2_2,6,6,180);
	}
}
