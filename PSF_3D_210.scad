
// PSF 3D BASE
// build volume
// x =
// y = 170;
// x =
use<PSF_3D_Lib.scad>
use<PSF_3D_Lib_Part.scad>
use<PSF_controller.scad>

use<prusa_y-belt-holder.scad>
use<e3d_v6_all_metall_hotend.scad>

size_x = 250;
size_y = 210;
size_z = 230;

load_l_x = size_x+20;
load_l_y = size_y;
load_l_z = size_z -10;

motor_l = 34;
belt_w = 6;
tpully_l =18;


base_x_t = 27; base_y_t = 10; base_z_t = 42;

top_x_t = 24; top_y_t = 20; top_z_t = 20;


y_load_offset_x = 68;
y_load_offset_z = 32;

y_belt_center = size_x/2-15;


y_pully_x = y_belt_center;
y_pully_y = base_y_t + 10;
y_pully_z = 42/2;


z_load_offset_x = 10;
z_load_offset_y = 55;
z_load_offset_z = 5;

x_load_offset_y = 30;

lz_b_offset1 = 5;
lz_b_offset2 = load_l_z - 5;


z_pully_x = 7 + 5;
z_pully_y = size_y/2;
z_pully_z = size_z - 10;


ly_b_offset1 = 5;
ly_b_offset2 = size_y -ly_b_offset1;

p_x=50; //0~150
p_y=0; //0~110
p_z=50; //0~120




color("darkkhaki") frame();

frame_parts();

color("LightGrey") frame_top();
frame_top_parts();

translate([0,p_y-50,0]){
	color("lightblue",1) bed();
	color("orange") bed_belt_holder();
	bed_parts();
}

translate([0,0,p_z-28]){
	color("SteelBlue") z_carriage();
	color("orange") z_carriage_motor_holder();
	z_carriage_part();

	translate([p_x-75,0,0]){
		color("darkgreen") x_carriage();
		color("lime") x_carriage_cover();
		color("orange") x_carriage_belt_holder();
		color("orange") x_carriage_fan_holder();
		color("orange") x_carriage_bltouch_holder();
		color("blue") x_carriage_part();
	}
}

translate([0,0,-40]){
	color("steelblue")lcd_frame();
	color("dimgray") control_frame();
	color("blue") control_frame_parts();

}


module x_carriage_part(){
	translate([size_x/2,size_y/2+x_load_offset_y,110]) rotate([0,90,0]) lm8uu(50);
	translate([size_x/2,size_y/2-x_load_offset_y,110]) rotate([0,90,0]) lm8uu(50);

	translate([size_x/2,size_y/2,150-1]) rotate([180,0,-90]) color("blue")e3d();

	translate([size_x/2-17.5,size_y/2,123]) rotate([0,-90,0]) translate([-125,-105,-5]) color("blue") import("40mmFan.stl");
	translate([size_x/2,size_y/2-40,98]) rotate([170,0,0,]) color("blue"){
		import("4010_Blower_Fan_v2.stl");
	}

	translate ([size_x/2 + 20,size_y/2,123]){
		rotate([0,0,90]) translate([2.15,-4.3,0]) import("Bltouch_v1.stl");
	}
}

module z_carriage_part(){
	// load
	x_load(0-10,size_y/2+x_load_offset_y,110,load_l_x);
	x_load(0-10,size_y/2-x_load_offset_y,110,load_l_x);
	// z bearing
	translate([10,size_y/2+z_load_offset_y,100-5]) rotate([0,0,0]) lm8uu(45);
	translate([10,size_y/2-z_load_offset_y,100-5]) rotate([0,0,0]) lm8uu(45);
	translate([size_x-10,size_y/2+z_load_offset_y,100-5]) rotate([0,0,0]) lm8uu(45);
	translate([size_x-10,size_y/2-z_load_offset_y,100-5]) rotate([0,0,0]) lm8uu(45);
	// x motor
	x_motor(-27-7,size_y/2+30,107);
	// x pully
	x_pully(size_x+3,size_y/2+30,92);

	color("Violet") belt(-35,size_y/2+30,92,290,"X");
}

module bed_parts()
{
	translate([y_load_offset_x,size_y/2,y_load_offset_z]) rotate([90,0,0]) lm8uu(70);
	translate([size_x-y_load_offset_x,size_y/2,y_load_offset_z]) rotate([90,0,0]) lm8uu(70);
}


module frame_parts(){
	y_load(y_load_offset_x,y_load_offset_z,load_l_y,ly_b_offset1,ly_b_offset2,size_x);
	y_pully(y_belt_center,20-5,21);
	y_motor(y_belt_center + 15,size_y-42/2 - base_y_t,42/2);

	module left_side(){
		z_load(z_load_offset_x,size_y/2+z_load_offset_y,z_load_offset_z,load_l_z,lz_b_offset1,lz_b_offset2);
		z_load(z_load_offset_x,size_y/2-z_load_offset_y,z_load_offset_z,load_l_z,lz_b_offset1,lz_b_offset2);
		z_pully(z_pully_x,z_pully_y,z_pully_z);
		z_motor(base_x_t-10,z_pully_y,42/2);
	}

	left_side();
	translate([size_x,0,0]) mirror([1,0,0]) left_side();

	color("Violet") belt(y_belt_center,20,21,size_y-47,"Y");
	color("Violet") belt(z_pully_x,z_pully_y,42/2,size_z-31,"Z");
	color("Violet") belt(size_x-z_pully_x,z_pully_y,42/2,size_z-31,"Z");
}

module x_carriage(){

	module tie_hole(x,y,z){
		translate([x,y,z]) rotate([0,90,0]) difference(){
			cylinder(d=25,h=4,$fn=32,center=true);
			cylinder(d=17,h=5,$fn=32,center=true);
			}
	}

	difference(){
			translate([size_x/2,size_y/2,125]){
			difference(){
				union(){
					cube([25,40,44],center=true);
					translate([0,-30,-12]) cube([50,20,20],center=true);
					translate([0,+30+3,-12]) cube([50,26,20],center=true);

				}

				translate([12.5,0,0])cube([25,40,44],center=true);
				translate([0,0,-22]) cylinder(d=22,h=28,$fn=32);
				translate([0,0,-22]) cylinder(d=5,h=100,$fn=32);
				translate([0,0,-8])cube([50,21,28],center=true);

				translate([0,0,-6]) rotate([0,90,0]) cylinder(d=30,h=100,$fn=32,center=true);

				// fan bolt
				bolt_m3_cut(-20,16,-2-16,"LEFT",10);
				bolt_m3_cut(-20,-16,-2-16,"LEFT",10);
				bolt_m3_cut(-20,16,-2+16,"LEFT",10);
				bolt_m3_cut(-20,-16,-2+16,"LEFT",10);

				// join bolt
				bolt_m3_cut(+10,16,-2-16+5,"RIGHT",20);
				bolt_m3_cut(+10,-16,-2-16+5,"RIGHT",20);
				bolt_m3_cut(+10,16,-2+16+5,"RIGHT", 20);
				bolt_m3_cut(+10,-16,-2+16+5,"RIGHT",20);

				// cable tie
				tie_hole(-20,-30,-15);
				tie_hole(+20,-30,-15);
				tie_hole(-20,+30,-15);
				tie_hole(+20,+30,-15);

				// bearing
				translate([0,-30,-15]) rotate([0,90,0]) cylinder(d=15.1,h=51,center=true);
				translate([0,+30,-15]) rotate([0,90,0]) cylinder(d=15.1,h=51,center=true);
			}
		}

		translate([size_x/2,size_y/2,150-1]) rotate([180,0,90]) e3d();

		// belt holder mount
		translate([size_x/2,size_y/2+36,90+2]) rotate([-90,-90,0]) {
			bolt_m3_cut(2,10,6,"LEFT",15);
			bolt_m3_cut(2,-10,6,"LEFT",15);
		}

		// fan holder mount
		translate([size_x/2,size_y/2-40,98]) rotate([170,0,0,]){
			// holder bolt
			translate([-12,2,-27]) rotate([10,0,0]) bolt_m3_cut(2,10,6,"BACK",15);
			translate([+8,2,-27]) rotate([10,0,0]) bolt_m3_cut(2,10,6,"BACK",15);
		}

		translate ([size_x/2 + 20,size_y/2,123]){

			bolt_m3_cut(-1,-25,8,"TOP",15);
			bolt_m3_cut(-1,25,8,"TOP",15);
		}
	}
}

module x_carriage_cover(){
	difference(){
			translate([size_x/2,size_y/2,125]){
			difference(){
				union(){
					translate([6.25,0,0])cube([12.5,40,44],center=true);
				}

				translate([0,0,-22]) cylinder(d=22,h=28,$fn=32);
				translate([0,0,-22]) cylinder(d=5,h=100,$fn=32);
				translate([0,0,-8])cube([50,21,28],center=true);

				translate([0,0,-6]) rotate([0,90,0]) cylinder(d=30,h=100,$fn=32,center=true);

				// join bolt
				bolt_m3_cut(+10,16,-2-16+5,"RIGHT",20);
				bolt_m3_cut(+10,-16,-2-16+5,"RIGHT",20);
				bolt_m3_cut(+10,16,-2+16+5,"RIGHT", 20);
				bolt_m3_cut(+10,-16,-2+16+5,"RIGHT",20);
			}
		}
		translate([size_x/2,size_y/2,150-1]) rotate([180,0,90]) e3d();
	}
}

module x_carriage_bltouch_holder(){
	translate ([size_x/2 + 20,size_y/2,123]){
		difference(){
			union(){
				translate([-1,0,5]) cube([12,60,5],center = true);
				translate([-1,-25,1.25]) cube([12,10,2.5],center=true);
				translate([-1,25,1.25]) cube([12,10,2.5],center=true);
			}

			bolt_m3_cut(-1,-25,8,"TOP",15);
			bolt_m3_cut(-1,25,8,"TOP",15);

			bolt_m3_cut(-1,-9,15,"TOP",15);
			bolt_m3_cut(-1,9,15,"TOP",15);
		}
	}
}

module x_carriage_belt_holder(){
	translate([size_x/2,size_y/2+36,90+2]) rotate([-90,-90,0])
	{
		difference(){
			union(){
			translate([0,0,-37]) y_belt_holder2();
			translate ([8,0,0.5]) cube([7,30,17],center=true);
			}

			bolt_m3_cut(2,10,6,"LEFT",10);
			bolt_m3_cut(2,-10,6,"LEFT",10);
		}
	}
}

module x_carriage_fan_holder(){
	translate([size_x/2,size_y/2-40,98]) rotate([170,0,0,]){
		difference(){
			union(){
				translate([0,0,-2]) cube([40,40,4],center=true);
				translate([-15,4.5,-25]) rotate([10,0,0]) cube([30,7,25]);
			}

			// holder bolt
			translate([-12,2,-27]) rotate([10,0,0]) bolt_m3_cut(2,10,6,"BACK",10);
			translate([+8,2,-27]) rotate([10,0,0]) bolt_m3_cut(2,10,6,"BACK",10);

			// fan bolt
			translate([18,18,0]) rotate([0,0,0]) cylinder(d=1.8,h=20,center=true);
			translate([-18,18,0]) rotate([0,0,0]) cylinder(d=1.8,h=20,center=true);
			translate([-18,-18,0]) rotate([0,0,0]) cylinder(d=1.8,h=20,center=true);
			translate([18,-18,0]) rotate([0,0,0]) cylinder(d=1.8,h=20,center=true);
		}
	}
}


module z_carriage_motor_holder(){
	difference(){
		translate([-34,size_y/2+30,97]) difference(){
			union(){
				cube([42,42,20],center = true);
				translate([21-5,0,0]) cube([10,70,20],center = true);
			}
			cylinder(d=23,h=21,$fn=32,center=true);
			translate([21/2,0,-0.5])cube([23,23,21],center=true);

			bolt_m3_cut(-15.5,-15.5,0,"BOTTOM",10);
			bolt_m3_cut(+15.5,-15.5,0,"BOTTOM",10);
			bolt_m3_cut(-15.5,+15.5,0,"BOTTOM",10);
			bolt_m3_cut(+15.5,+15.5,0,"BOTTOM",10);
		}

		bolt_m3_cut(-34+10,size_y/2+30+27,97,"LEFT",15);
		bolt_m3_cut(-34+10,size_y/2+30-27,97,"LEFT",15);
	}
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
				translate([0-3,size_y/2,100-5]) cube([20,110,45],center=true);
				translate([2,size_y/2+z_load_offset_y,100-5]) cube([30,20,45],center=true);
				translate([2,size_y/2-z_load_offset_y,100-5]) cube([30,20,45],center=true);
				translate([11,size_y/2-6,95]) rotate([-90,0,180]) translate([0,0,-37]) y_belt_holder2();
			}
			tie_hole(10,size_y/2+z_load_offset_y,100+5);
			tie_hole(10,size_y/2+z_load_offset_y,100-20);
			tie_hole(10,size_y/2-z_load_offset_y,100+5);
			tie_hole(10,size_y/2-z_load_offset_y,100-20);

			// x pully
			translate([-3,size_y/2+30,92]) cube([30,20,10],center=true);
			bolt_m3_cut(-3,size_y/2+30,92-15,"BOTTOM",30);


			// z bearing
			translate([10,size_y/2+z_load_offset_y,100-5]) cylinder(d=15.1,h=46,center=true);
			translate([10,size_y/2-z_load_offset_y,100-5]) cylinder(d=15.1,h=46,center=true);
		}
	}


	translate([size_x,0,0]) mirror([1,0,0]) base();

	difference()
	{
		union(){
			base();
		}

		bolt_m3_cut(-34+10,size_y/2+30+27,97,"LEFT",15);
		bolt_m3_cut(-34+10,size_y/2+30-27,97,"LEFT",15);
	}
}


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
			translate([y_load_offset_x,size_y/2,y_load_offset_z+7]) cube([20,70,25],center=true);
			translate([size_x-y_load_offset_x,size_y/2,y_load_offset_z+7]) cube([20,70,25],center=true);
		}

		bolt_m3_cut(y_belt_center,size_y/2 -19-7,36,"BOTTOM",10);
		bolt_m3_cut(y_belt_center,size_y/2 +19-7,36,"BOTTOM",10);

		translate([y_load_offset_x,size_y/2,y_load_offset_z]) rotate([90,0,0]) cylinder(d=15.1,h=90,$fn=32,center=true);
		translate([size_x-y_load_offset_x,size_y/2,y_load_offset_z]) rotate([90,0,0]) cylinder(d=15.1,h=91,$fn=32,center=true);

		// cable tie hole
		tie_hole(y_load_offset_x,size_y/2-20,y_load_offset_z);
		tie_hole(y_load_offset_x,size_y/2+20,y_load_offset_z);

		tie_hole(size_x-y_load_offset_x,size_y/2-20,y_load_offset_z);
		tie_hole(size_x-y_load_offset_x,size_y/2+20,y_load_offset_z);
	}
}


module bed_belt_holder(){
	translate([y_belt_center,size_y/2-7,-11]) y_belt_holder();
}


module frame_top(){

	module left(){
		difference(){
			translate([0,15,size_z-top_z_t]) cube([top_x_t,size_y-30,top_z_t]);

			// z pully
			translate([z_pully_x -5,z_pully_y-10,z_pully_z-25]) cube([10,20,50]);
			bolt_m3_cut(top_x_t,z_pully_y,size_z-10,"RIGHT",20+0.5);

			// z load
			translate([z_load_offset_x,size_y/2+z_load_offset_y,z_load_offset_z]) rotate([0,0,0]) cylinder(d=8.1,h=load_l_z+1,$fn=32); //z load
			bolt_m3_cut(top_x_t,size_y/2+z_load_offset_y,size_z-10,"RIGHT",7);

			translate([z_load_offset_x,size_y/2-z_load_offset_y,z_load_offset_z]) rotate([0,0,0]) cylinder(d=8.1,h=load_l_z+1,$fn=32); //z load
			bolt_m3_cut(top_x_t,size_y/2-z_load_offset_y,size_z-10,"RIGHT",7);

			// top bolt
			bolt_m3_cut(12,15+10,size_z-10,"TOP",20);
			bolt_m3_cut(12,size_y-15-10,size_z-10,"TOP",20);
		}
	}

	left();

	translate([size_x,0,0]) mirror([1,0,0]) left();

	//translate([24,15,size_z-top_z_t]) cube([size_x-24-24,top_y_t,top_z_t]); // 앞
	translate([24,size_y-15-top_y_t,size_z-top_z_t]) cube([size_x-24-24,top_y_t,top_z_t]); //뒤

	// extruder motor
	difference() {
		translate([size_x-5,size_y-42-15-5,size_z]) cube([5,42,42]);
		bolt_m3_cut(size_x+5,size_y-20-21+15.5,size_z+21-15.5,"RIGHT",12);
		bolt_m3_cut(size_x+5,size_y-20-21+15.5,size_z+21+15.5,"RIGHT",12);
		bolt_m3_cut(size_x+5,size_y-20-21-15.5,size_z+21-15.5,"RIGHT",12);
		bolt_m3_cut(size_x+5,size_y-20-21-15.5,size_z+21+15.5,"RIGHT",12);

	}
	translate([size_x-25,size_y-20,size_z]) cube([25,5,42]);

	// cable guide
	translate([size_x-24,size_y-15,size_z-20]) difference(){
		cube([24,15,10]);
		translate ([3,0,-1]) cube([18,12,30]);
	}
}

module frame_top_parts(){
	e_motor(size_x-5,size_y-15-21-5,size_z+21);
}


module frame (){
	difference(){
		union(){
			frame_left();
			translate([size_x,0,0]) mirror([1,0,0]) frame_left();
			frame_front();
			frame_back();
		}
        //contorller
        bolt_m3_cut(40,20,30-40,"BOTTOM",15);
        bolt_m3_cut(250-40,20,30-40,"BOTTOM",15);
        bolt_m3_cut(40,210-20,30-40,"BOTTOM",15);
        bolt_m3_cut(250-40,210-20,30-40,"BOTTOM",15);

        bolt_m3_cut(20,40,30-40,"BOTTOM",15);
        bolt_m3_cut(250-20,40,30-40,"BOTTOM",15);
        bolt_m3_cut(20,210-40,30-40,"BOTTOM",15);
        bolt_m3_cut(250-20,210-40,30-40,"BOTTOM",15);
	}
}


module frame_left(){

	module tie_hole(x,y,z){
		translate([x,y,z]) rotate([0,0,0]) difference(){
			cylinder(d=20,h=4,$fn=32,center=true);
			cylinder(d=12,h=5,$fn=32,center=true);
			}
	}

	difference(){
		union(){
			cube([base_x_t,size_y,base_z_t]);
			translate([0,15,0]) cube([top_x_t,top_y_t,size_z-20]); //front
			translate([0,size_y-top_y_t-15,0]) cube([top_x_t,top_y_t,size_z-20]); //back

			cube([50,size_y,10]); //bottom
		}

		// z load
		translate([z_load_offset_x,size_y/2+z_load_offset_y,z_load_offset_z]) rotate([0,0,0]) cylinder(d=8.1,h=load_l_z+1,$fn=32); //z load
		//bolt_m3_cut(top_x_t,size_y/2+z_load_offset_y,size_z-5,"RIGHT",7);
		bolt_m3_cut(top_x_t,size_y/2+z_load_offset_y,42-5,"RIGHT",7);

		translate([z_load_offset_x,size_y/2-z_load_offset_y,z_load_offset_z]) rotate([0,0,0]) cylinder(d=8.1,h=load_l_z+1,$fn=32); //z load
		//bolt_m3_cut(top_x_t,size_y/2-z_load_offset_y,size_z-5,"RIGHT",7);
		bolt_m3_cut(top_x_t,size_y/2-z_load_offset_y,42-5,"RIGHT",7);

		// z motor
		translate([7,z_pully_y-11,21]) cube([10,22,50]);
		translate([base_x_t-10,z_pully_y-21.5,0-0.5]) cube([40,43,43]);
		translate([base_x_t+20,z_pully_y-31,-0.5]) cube([10,10,43]);
		translate([base_x_t+0.5,z_pully_y,21]) rotate([0,-90,0]) cylinder(d=23,h=50,$fn=32);

		bolt_m3_cut(7,z_pully_y-15.5,21+15.5,"LEFT",12);
		bolt_m3_cut(7,z_pully_y-15.5,21-15.5,"LEFT",12);
		bolt_m3_cut(7,z_pully_y+15.5,21-15.5,"LEFT",12);
		bolt_m3_cut(7,z_pully_y+15.5,21+15.5,"LEFT",12);

		// top bolt
		bolt_m3_cut(12,15+10,size_z-10,"TOP",20);
		bolt_m3_cut(12,size_y-15-10,size_z-10,"TOP",20);

		// cable guide
		translate ([3,size_y-15,-1]) cube([18,12,50]);

		tie_hole(12,size_y-15,50);
		tie_hole(12,size_y-15,100);
		tie_hole(12,size_y-15,150);
		tie_hole(12,size_y-15,200);
	}
}


module frame_front(){
	difference(){
		union(){
			cube([size_x,base_y_t,base_z_t]);
			cube([size_x,40,10]);
			translate([y_belt_center-12,0,0]) cube([24,25,31]);
		}

		//y pully
		translate([y_belt_center-5,10-5,10]) cube([10,50,50]);
		bolt_m3_cut(y_belt_center+13,15,21,"RIGHT",27);

		//y load
		translate([y_load_offset_x,-0.5, y_load_offset_z]) rotate([-90,0,0]) cylinder(d=8.1,h=load_l_y+1,$fn=32);
		translate([size_x-y_load_offset_x,-0.5, y_load_offset_z]) rotate([-90,0,0]) cylinder(d=8.1,h=load_l_y+1,$fn=32);

		bolt_m3_cut(y_load_offset_x+9,5,42-1,"TOP_R45",6);
		bolt_m3_cut(size_x-y_load_offset_x-9,5,42-1,"TOP_L45",6);
	}
}


module frame_back(){

	difference(){
		union(){
			translate([0,size_y-base_y_t,0]) cube([size_x,base_y_t,base_z_t]);
			translate([0,size_y-40,0]) cube([size_x,40,10]);

			//translate([0,size_y-top_y_t,size_z-top_z_t*2]) cube([size_x,top_y_t,top_z_t*2]);

			translate([y_belt_center+15-10,size_y-52,0]) cube([10,52,42]);

			//translate([0,z_load_offset_y+10,size_z-top_z_t]) cube([size_x,top_y_t,top_z_t]);
			//translate([y_belt_center+2.5,size_y-11,-5])rotate([0,0,180])mirror([1,0,0]) holder();
		}
		translate([0,0,-30]) cube([300,300,30]);

		//y load
		translate([y_load_offset_x,-0.5, y_load_offset_z]) rotate([-90,0,0]) cylinder(d=8.1,h=load_l_y+1,$fn=32);
		translate([size_x-y_load_offset_x,-0.5, y_load_offset_z]) rotate([-90,0,0]) cylinder(d=8.1,h=load_l_y+1,$fn=32);

		bolt_m3_cut(y_load_offset_x+9,size_y-5,42-1,"TOP_R45",6);
		bolt_m3_cut(size_x-y_load_offset_x-9,size_y-5,42-1,"TOP_L45",6);

		//y motor
		translate([y_belt_center+15,size_y-10-42,0]) cube([40,42,42]);
		translate([y_belt_center+15+0.5,size_y-10-21,21]) rotate([0,-90,0]) cylinder(d=23, h=20, $fn=32);
		translate([y_belt_center+15+0.5-20,size_y-10-43,21-11]) cube([20,30,40]);

		bolt_m3_cut(y_belt_center+5,size_y-10-21-15.5,21+15.5,"LEFT",10);
		bolt_m3_cut(y_belt_center+5,size_y-10-21+15.5,21+15.5,"LEFT",10);
		bolt_m3_cut(y_belt_center+5,size_y-10-21-15.5,21-15.5,"LEFT",10);

		// cable guide
		translate ([3,size_y-15,-1]) cube([18,12,50]);
		translate ([size_x+3-24,size_y-15,-1]) cube([18,12,50]);
	}
}