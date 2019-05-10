
// PSF 3D BASE



include<PSF_3D_lib.scad>
include<PSF_3D_timing_belts.scad>

use<prusa_y-belt-holder.scad>
use<prusa_y-belt-idler.scad>
use<prusa_y-motor-holder.scad>





module m3_bolt(l,t)
{
	color("Lime",0.5) union(){
		cylinder(d=m3_hd, h= m3_hh,$fn=32);
		if (t==true){
			translate([0,0,3.5]) cylinder(d= m3_d+0.1, h = l, $fn=32);
		}
		else{
			translate([0,0,3.5]) cylinder(d= m3_d-0.2, h = l, $fn=32);
		}
	}
}


module left_side2(){
	

	base_width = 7+10+7;
	base_hight = 42;
	
	
	
	v_pully_offset_x = 12;
	v_pully_offset_y = 140;
	v_pully_offset_z1 = 15;
	v_pully_offset_z2 = 300 - (base_hight/2);
	
	module base(){
		
		translate([0,0,0]) rotate([0,0,0])cube([base_width,300,base_hight]);
		translate([0,0,300-20]) rotate([0,0,0]) cube([base_width,300,20]);
		
		translate([0,0,0]) rotate([0,0,0]) cube([base_width,30,300]);
		translate([0,270,0]) rotate([0,0,0]) cube([base_width,30,300]);

	}
	
	module load_z (){
		translate([z_load_offset_x,z_load_offset_y,+5]) {
		rotate([0,0,0]) cylinder(d=load_d,h=300,$fn=32);
		translate([-z_load_offset_x-0.1,0,5]) rotate([0,90,0]) m3_bolt(10,false);
		translate([-z_load_offset_x-0.1,0,25]) rotate([0,90,0]) m3_bolt(10,false);
		translate([-z_load_offset_x-0.1,0,285]) rotate([0,90,0]) m3_bolt(10,false);
		translate([-z_load_offset_x-0.1,0,265]) rotate([0,90,0]) m3_bolt(10,false);
		}
	}
	
	module v_pully_top(){
		translate([v_pully_offset_x,v_pully_offset_y,v_pully_offset_z2]){ 
			rotate([0,0,0]) cube ([10,20,52],center = true);
			translate ([-12.1,0,0]) rotate([0,90,0]) m3_bolt(30,false);
		}
	}
	
	module v_pully_bot(){
		translate([v_pully_offset_x,v_pully_offset_y,v_pully_offset_z1]){
			rotate([0,0,0]) cube ([10,20,52],center = true);
			rotate([0,90,0]) cylinder(d=8.1,h=80,$fn=16, center = true);
			translate([-9,0,0]) rotate([0,90,0]) cylinder(d=22.1,h=8, $fn=32,center = true);
			translate([9,0,0]) rotate([0,90,0]) cylinder(d=22.1,h=8, $fn=32, center = true);
		}
	}
	
	
	difference(){
		base();
		load_z();
		v_pully_bot();
		v_pully_top();
	}
	
	//load_v();
	//v_pully_top();

}





module motor(x,y,z){
	translate ([x,y,z]) rotate([0,-90,0]){
		stepper_motor(motor_l);
		translate ([0,0,motor_l+2.5]) rotate([0,0,0]) t_pully(5);
	}
}


module load_y(x,z){
	translate ([x,0, z]) rotate([-90,0,0]){
		load(load_l);
		translate ([0,0,100]) lm8uu();
		translate ([0,-10,ly_b_offset1]) rotate([-90,0,0]) bolt_m3(5);
		translate ([0,-10,ly_b_offset2]) rotate([-90,0,0]) bolt_m3(5);
		
	}
	translate ([size_x - x,0, z]) rotate([-90,0,0]){
		load(load_l);
		translate ([0,0,140]) lm8uu();
		translate ([0,0,180]) lm8uu();
		translate ([0,-10,ly_b_offset1]) rotate([-90,0,0]) bolt_m3(5);
		translate ([0,-10,ly_b_offset2]) rotate([-90,0,0]) bolt_m3(5);
	}
}


module load_z_left (x,y,z){
	translate([x,y,z]) {
		rotate([0,0,0]) load(load_l);
		
		translate ([0,0,100]) lm8uu();
		translate ([0,0,130]) lm8uu();
		
		translate ([-x,0,lz_b_offset1]) rotate([0,90,0]) bolt_m3(5);
		translate ([-x,0,lz_b_offset2]) rotate([0,90,0]) bolt_m3(5);

		
	}
}

module pully_z (x,y,z){
	
	translate([x,y,z]){
		rotate([0,90,0]){
			i_pully();
			translate ([0,0,-7]) rotate([0,0,0]) bolt_m3(20);
		}
	}
	
	translate([size_x,0,0]) mirror([1,0,0]) translate([x,y,z]){
		rotate([0,90,0]){
			i_pully();
			translate ([0,0,-7]) rotate([0,0,0]) bolt_m3(20);
		}
	}
}


module belt_y(x=139,y=20,z=15,l=250){
	
	translate([x,y,z])rotate([90,0,90])color("aquamarine") {
		belt_len(tGT2_2,6, l);
		translate([l,12,0]) rotate([0,0,180]) belt_len(tGT2_2,6,l);
		translate([ 0,12,0]) rotate([0,0,180]) belt_angle(tGT2_2,6,6,180);
		translate([l,0,0]) rotate([0,0,0]) belt_angle(tGT2_2,6,6,180);
	}
	
}

module belt_z(x=12,y=140-6,z=15-3,l=290){
	translate([x,y,z])rotate([0,-90,0])color("aquamarine") {
		belt_len(tGT2_2,6, l);
		translate([l,12,0]) rotate([0,0,180]) belt_len(tGT2_2,6,l);
		translate([ 0,12,0]) rotate([0,0,180]) belt_angle(tGT2_2,6,6,180);
		translate([l,0,0]) rotate([0,0,0]) belt_angle(tGT2_2,6,6,180);
	}
	
	translate([size_x-x,y,z])rotate([0,-90,0])color("aquamarine") {
		belt_len(tGT2_2,6, l);
		translate([l,12,0]) rotate([0,0,180]) belt_len(tGT2_2,6,l);
		translate([ 0,12,0]) rotate([0,0,180]) belt_angle(tGT2_2,6,6,180);
		translate([l,0,0]) rotate([0,0,0]) belt_angle(tGT2_2,6,6,180);
	}
}
	



size_x = 300;
size_y = 300;
size_z = 332;

load_l = 300;
motor_l = 34;
belt_w = 6;
tpully_l =18;


base_x_t = 27;
base_y_t = 10;
base_z_t = 42;

top_x_t = 24;
top_y_t = 20;
top_z_t = 20;

module base_left(){
	difference(){
		union(){
			cube([base_x_t,size_y,base_z_t]);
			cube([top_x_t,top_y_t,size_z]);
			
			cube([50,size_y,10]);
			
			translate([0,size_y-top_y_t,0]) cube([top_x_t,top_y_t,size_z]);
			translate([0,0,size_z-top_z_t]) cube([top_x_t,size_y,top_z_t]);
			translate([0,size_y/3,0]) cube([top_x_t,top_y_t,size_z]);
			//translate([0,size_y/3*2,0]) cube([top_x_t,top_y_t,size_z]);
			
			translate([0,0,size_z-110]) rotate([-45,0,0]) cube([top_x_t,top_y_t,150]);
			translate([0,size_y-120,30]) rotate([-45,0,0]) cube([top_x_t,top_y_t,150]);
			
		}
		
		//translate([-10,-50,size_z-162]) cube([50,50,50]);
		//translate([-10,100,size_z]) cube([50,50,50]);
		//translate([-10,-150,332]) rotate([-45,0,0]) cube ([50,200,200]);
	}
}

module base_front(){
	cube([size_x,base_y_t,base_z_t]);
	cube([size_x,40,10]);
	translate([0,0,size_z-top_z_t*2]) cube([size_x,top_y_t,top_z_t*2]);
	translate([0,size_y/3*2,size_z-top_z_t]) cube([size_x,top_y_t,top_z_t]);
	translate([0,size_y/3*2,0]) cube([size_x,top_y_t,10]);
	translate([size_x/2,3,43])rotate([180,0,0]) Y_belt_idler();
}

module base_back(){
	
	difference(){
		union(){
			translate([0,size_y-base_y_t,0]) cube([size_x,base_y_t,base_z_t]);
			translate([0,size_y-40,0]) cube([size_x,40,10]);
			
			
			translate([0,size_y-top_y_t,size_z-top_z_t*2]) cube([size_x,top_y_t,top_z_t*2]);
			//translate([0,z_load_offset_y+10,size_z-top_z_t]) cube([size_x,top_y_t,top_z_t]);
			translate([size_x/2+2.5,size_y-11,-5])rotate([0,0,180])mirror([1,0,0]) holder();
		}
		translate([0,0,-30]) cube([300,300,30]);
	}
}

base_left();
translate([size_x,0,0]) mirror([1,0,0]) base_left();
base_front();
base_back();

//--------------------------------------
z_load_offset_x = 10;
z_load_offset_y = size_y / 2 + 20;
z_load_offset_z = 42-10;

lz_b_offset1 = 5;
lz_b_offset2 = load_l - 5;


z_pully_x = 7;
z_pully_y = z_load_offset_y - 20;
z_pully_z = size_z - 10;


y_load_offset_x = 80;
y_load_offset_z = 32;

ly_b_offset1 = 5;
ly_b_offset2 = size_y -ly_b_offset1;

y_belt_x = 150;
y_belt_y = 20;
y_belt_z = 15;


//%load_z_left(z_load_offset_x,z_load_offset_y,z_load_offset_z);
//%translate([size_x,0,0]) mirror([1,0,0]) load_z_left(z_load_offset_x,z_load_offset_y,z_load_offset_z);

//%pully_z(z_pully_x,z_pully_y,z_pully_z);

//%load_y(y_load_offset_x,y_load_offset_z);


//%motor(base_x_t+34,z_pully_y,42/2); // z1
//%translate([size_x,0,0]) mirror ([1,0,0]) motor(base_x_t+34,z_pully_y,42/2); // z2

//%motor(size_x/2+motor_l+tpully_l-belt_w/2 +0.5,size_y-42/2 - base_y_t,42/2); //y


//%belt_y(size_x/2,20,15,260);
//%belt_z(12,z_pully_y-6,42/2-3,305);

