// Printed Single Frame 3D printer
// bed

use<prusa_y-belt-holder.scad>

include<PSF_3D_210_define.scad>
include<PSF_3D_lib.scad>
include<PSF_3D_210_define.scad>


bed();
%bed_parts();

module bed(){
	
	bed_size_x = size_x - 60;
	bed_size_y = size_y - 80;
	
	module tie_hole(x,y,z){
		translate([x,y,z]) rotate([90,0,0]) difference(){
			cylinder(d=25,h=4,$fn=32,center=true);
			cylinder(d=17,h=5,$fn=32,center=true);
			}
	}
	
	module magnet(x,y,z){
		translate([x,y,z-1]) cube([6.5,20.5,9], center=true);
	}
	
	difference (){
		union(){
			translate([size_x/2,size_y/2,42+8]) cube([bed_size_x,bed_size_y,10],center = true);
			translate([y_belt_center,size_y/2-7,42+4]) cube([15,60,10],center = true);
			
			// slide unit support
			translate([y_load_offset_x,size_y/2,y_load_offset_z+7]) cube([16,70,20],center=true);
			translate([size_x-y_load_offset_x,size_y/2,y_load_offset_z+7]) cube([16,70,20],center=true);
		}
		
		bolt_m3_cut(y_belt_center,size_y/2 -19-7,36,"BOTTOM",10);
		bolt_m3_cut(y_belt_center,size_y/2 +19-7,36,"BOTTOM",10);
		
		translate([y_load_offset_x,size_y/2,y_load_offset_z]) rotate([90,0,0]) cylinder(d=15.1,h=90,$fn=32,center=true);
		translate([size_x-y_load_offset_x,size_y/2,y_load_offset_z]) rotate([90,0,0]) cylinder(d=15.1,h=91,$fn=32,center=true);
		
		// cable tie hole
		tie_hole(y_load_offset_x,size_y/2-20,y_load_offset_z);
		tie_hole(y_load_offset_x,size_y/2+20,y_load_offset_z);
		//tie_hole(y_load_offset_x,size_y/2+40,y_load_offset_z);
		
		tie_hole(size_x-y_load_offset_x,size_y/2-20,y_load_offset_z);
		tie_hole(size_x-y_load_offset_x,size_y/2+20,y_load_offset_z);
		//tie_hole(size_x-y_load_offset_x,size_y/2+40,y_load_offset_z);
		
		// magnetic hole
		
		for(i=[0:2]){
			for(j=[0:3]){
				k = size_y/2 - bed_size_y/2 + 20 + (bed_size_y-40)/2*i;
				l = size_x/2 - bed_size_x/2 + 15 + (bed_size_x-30)/3*j;
				
				//magnet(l,k,50);
			}
		}
	}
	

}

module bed_parts()
{
	color("blue") translate([y_belt_center,size_y/2-7,-11]) y_belt_holder();
	translate([y_load_offset_x,size_y/2,y_load_offset_z]) rotate([90,0,0]) lm8uu(50);
	translate([size_x-y_load_offset_x,size_y/2,y_load_offset_z]) rotate([90,0,0]) lm8uu(50);
}
