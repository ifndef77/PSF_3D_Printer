// PSF_3D Lib


module rgb(c,a=1) {

	function hexDigit(d="") =
    len(d) != 1 ? undef :
    d[0] == "0" ? 0 :
    d[0] == "1" ? 1 :
    d[0] == "2" ? 2 :
    d[0] == "3" ? 3 :
    d[0] == "4" ? 4 :
    d[0] == "5" ? 5 :
    d[0] == "6" ? 6 :
    d[0] == "7" ? 7 :
    d[0] == "8" ? 8 :
    d[0] == "9" ? 9 :
	d[0] == "A" ? 10 :
    d[0] == "B" ? 11 :
    d[0] == "C" ? 12 :
    d[0] == "D" ? 13 :
    d[0] == "E" ? 14 :
    d[0] == "F" ? 15 :
    d[0] == "a" ? 10 :
    d[0] == "b" ? 11 :
    d[0] == "c" ? 12 :
    d[0] == "d" ? 13 :
    d[0] == "e" ? 14 :
    d[0] == "f" ? 15 : (0/0); // 0/0=nan

	color([
	(hexDigit(c[1])*16+hexDigit(c[2]))/255,
	(hexDigit(c[3])*16+hexDigit(c[4]))/255,
	(hexDigit(c[5])*16+hexDigit(c[6]))/255,
	a]) children();
}


module teardrop (dia, length, angle)
{
    linear_extrude(height = length )
    {
        union ()
        {
            //circle (d=dia, $fn = dia*4);
			circle (d=dia, $fn = dia*4);
            polygon ([
            [sin(90-angle)*-dia/2,cos(90-angle)*dia/2],
            [0,dia/2/sin(angle)],
            [sin(90-angle)*dia/2,cos(90-angle)*dia/2]],
            convexity = 10);
        }
    }
}

module bolt_m3(l)
{

	m3_d = 3;
	m3_hd = 5.5;
	m3_hh = 3;


	color("black") difference(){
			union(){
			cylinder(d=m3_hd, h= m3_hh,$fn=32);
			translate([0,0,3]) cylinder(d= m3_d, h = l, $fn=32);
		}
		cylinder(d=3,h=2.7,$fn=6);
	}
}

module bolt_m3_cut(x,y,z,d,l)
{
	module cut(length){
		color("Lime",0.5) union(){
			translate([0,0,-30]) cylinder(d=6, h= 34,$fn=32);
			translate([0,0,4]) cylinder(d= 2.8, h = l, $fn=32);
		}
	}
	translate([x,y,z]){
		if (d == "BOTTOM") rotate([0,0,0]) cut(l);
		else if (d == "TOP") rotate([180,0,0]) cut(l);
		else if (d == "LEFT") rotate([0,90,0]) cut(l);
		else if (d == "RIGHT") rotate([0,-90,0]) cut(l);
		else if (d == "FRONT") rotate([-90,0,0]) cut(l);
		else if (d == "BACK") rotate([90,0,0]) cut(l);
		else if (d == "TOP_L45") rotate([180,-45,0]) cut(l);
		else if (d == "TOP_R45") rotate([180,45,0]) cut(l);
	}
}

module stepper_motor(l)
{
	color("DodgerBlue",1) difference(){
		union(){
			translate ([-21,-21,-l]) cube([42,42,l]);
			translate ([-13.25,-26.5,-l]) cube ([20,6.5,12]);
			translate ([0,0,0]) cylinder(d=22,h=2, $fn=32);
			translate ([0,0,0]) cylinder(d=5,h=20, $fn=32);
		}

		translate ([15.5,15.5,-4])cylinder(d=3,h=5,$fn=32);
		translate ([-15.5,15.5,-4])cylinder(d=3,h=5,$fn=32);
		translate ([15.5,-15.5,-4])cylinder(d=3,h=5,$fn=32);
		translate ([-15.5,-15.5,-4])cylinder(d=3,h=5,$fn=32);
	}
}

module i_pully()
{
	color ("Cyan",1) difference(){
		union(){
			translate ([0,0,4.25-0.5]) cylinder(d=18, h=1, $fn=32,center=true);
			translate ([0,0,0]) cylinder(d=12, h=8.5, $fn=32,center = true);
			translate ([0,0,-4.25+0.5]) cylinder(d=18,h=1, $fn=32,center=true);
			}
		cylinder(d=3,h=20,$fn=32,center = true);
		}
}



module t_pully(d)
{
	color("Cyan",1) translate([0,0,-9-3.75]) difference(){
		union(){
			translate ([0,0,0]) cylinder(d=18,h=9, $fn=32);
			translate ([0,0,9]) cylinder(d=12,h=7.5, $fn=32);
			translate ([0,0,9+7.5]) cylinder(d=18,h=1.5, $fn=32);
		}
		translate ([0,0,-15])cylinder(d=d,h=40,$fn=32);
	}
}


module load(l,d=8)
{

	color("Cyan",1) cylinder(d=8, h=l);
}

module b608()
{
	color("green",1) difference(){
		cylinder(d=22,h=7,$fn=32,center = true);
		cylinder(d=8,h=20,center = true,$fn=32);
	}
}

module lm8uu(l=24)
{
	color("green",1) difference(){
		cylinder(d=15,h=l,center=true,$fn=32);
		cylinder(d=8,h=l+1,center=true,$fn=32);
	}
}




module mf128(){
	color("green",1) difference(){
		union(){
			cylinder(d=13.6,h=0.8,$fn=32);
			cylinder(d=12,h=3.5,$fn=32);
		}
		cylinder(d=8,h=20,center=true,$fn=32);
	}
}
