// PSF_3D Lib Part

use<PSF_3D_Lib.scad>
include<PSF_3D_timing_belts.scad>

use<e3d_v6_all_metall_hotend.scad>


module  belt(x,y,z,l,d){

	function get_vec(d) = (d=="X") ? [0,0,0] : (d=="Y") ? [90,0,90] : (d=="Z") ?  [0,-90,0] : [0,0,0];

	translate([x,y,z-6])rotate(get_vec(d)){
		belt_len(tGT2_2,6, l);
		translate([l,12,0]) rotate([0,0,180]) belt_len(tGT2_2,6,l);
		translate([ 0,12,0]) rotate([0,0,180]) belt_angle(tGT2_2,6,6,180);
		translate([l,0,0]) rotate([0,0,0]) belt_angle(tGT2_2,6,6,180);
	}
}

// z carriage parts
module x_load(x,y,z,l){

	translate ([x,y,z]) rotate([0,90,0]){
		load(l);
		//translate ([0,0,size_y/2+30]) lm8uu();
		//translate ([0,0,size_y/2-30]) lm8uu();
		//translate ([9,-8,ly_b_offset1]) rotate([-90,0,45]) bolt_m3(5);
		//translate ([9,-8,ly_b_offset2]) rotate([-90,0,45]) bolt_m3(5);

	}

}

module x_pully(x,y,z){
	translate ([x,y,z]) rotate ([0,0,0]){
		i_pully();
		translate ([0,0,+10+2.5]) rotate([0,180,0]) bolt_m3(20);
	}
}

module x_motor(x,y,z,l=34){
	translate ([x,y,z]) rotate([180,0,0]){
		stepper_motor(l);
		translate ([0,0,15]) rotate([0,0,0]) t_pully(5);
		translate ([15.5,15.5,10]) rotate([0,180,0]) bolt_m3(10);
		translate ([-15.5,15.5,10]) rotate([0,180,0]) bolt_m3(10);
		translate ([15.5,-15.5,10]) rotate([0,180,0]) bolt_m3(10);
		translate ([-15.5,-15.5,10]) rotate([0,180,0]) bolt_m3(10);

	}
}


// frame top parts
module y_pully(x,y,z){
	translate ([x,y,z]) rotate ([0,90,0]){
		i_pully();
		translate ([0,0,+10+2.5]) rotate([0,180,0]) bolt_m3(20);
	}
}

module e_motor(x,y,z,l=34){
	translate ([x,y,z]) rotate([180,-90,0]){
		stepper_motor(l);
		translate ([0,0,15]) rotate([0,0,0]) t_pully(5);
		translate ([15.5,15.5,10]) rotate([0,180,0]) bolt_m3(10);
		translate ([-15.5,15.5,10]) rotate([0,180,0]) bolt_m3(10);
		translate ([15.5,-15.5,10]) rotate([0,180,0]) bolt_m3(10);
		translate ([-15.5,-15.5,10]) rotate([0,180,0]) bolt_m3(10);

	}
}

// frame parts
module y_load(x,z,l,b1,b2,x_max){
	translate ([x,0, z]) rotate([-90,0,0]){
		load(l);
		translate ([9,-8,b1]) rotate([-90,0,45]) bolt_m3(5);
		translate ([9,-8,b2]) rotate([-90,0,45]) bolt_m3(5);

	}
	translate ([x_max - x,0, z]) rotate([-90,0,0]){
		load(l);
		translate ([-9,-8,b1]) rotate([-90,0,-45]) bolt_m3(5);
		translate ([-9,-8,b2]) rotate([-90,0,-45]) bolt_m3(5);
	}
}


module y_motor(x,y,z,l=34){
	translate ([x,y,z]) rotate([0,-90,0]){
		stepper_motor(l);
		translate ([0,0,15]) rotate([0,0,0]) t_pully(5);

		translate ([15.5,15.5,10]) rotate([0,180,0]) bolt_m3(10);
		translate ([-15.5,-15.5,10]) rotate([0,180,0]) bolt_m3(10);

	}
}


module z_load (x,y,z,l,b1,b2){
	translate([x,y,z]) {
		rotate([0,0,0]) load(l);

		translate ([-x+24,0,b1]) rotate([0,-90,0]) bolt_m3(5);
		translate ([-x+24,0,b2]) rotate([0,-90,0]) bolt_m3(8);
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

module z_motor(x,y,z,l=34){
	translate ([x,y,z]) rotate([0,-90,0]){
		stepper_motor(l);
		translate ([0,0,15]) rotate([0,0,0]) t_pully(5);
		translate ([15.5,15.5,10]) rotate([0,180,0]) bolt_m3(10);
		translate ([-15.5,15.5,10]) rotate([0,180,0]) bolt_m3(10);
		translate ([15.5,-15.5,10]) rotate([0,180,0]) bolt_m3(10);
		translate ([-15.5,-15.5,10]) rotate([0,180,0]) bolt_m3(10);

	}
}