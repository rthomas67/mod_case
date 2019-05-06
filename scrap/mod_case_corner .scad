// mod-case
// corner
use <mod_case_opening_corner.scad>

devCornerDia=10;
devCornerHeight=40;
devCornerWidth=50;

verticalRodDia=8;
horizontalRodDia=6;

panelThickness=2.5;

slotDepth=panelThickness*3;

$fn=50;
overlap=0.01;

corner(devCornerDia,devCornerHeight,devCornerWidth);

module corner(cornerDia,cornerHeight,cornerWidth) {
    difference() {
        openingCorner(cornerDia,cornerHeight,cornerWidth);
        translate([cornerDia/2,cornerDia/2,0])
        difference() {
           translate([-cornerDia,-cornerDia,-overlap])        
                cube([cornerWidth+cornerDia+overlap,cornerWidth+cornerDia+overlap,
                    cornerWidth+cornerDia+overlap]);
           hull() {
                translate([0,0,cornerHeight-cornerDia/2])
                    sphere(d=cornerDia);
                translate([0,0,-cornerDia])
                    cylinder(d=cornerDia, h=cornerHeight+overlap*2);
                translate([0,0,cornerHeight-cornerDia/2])
                    rotate([0,90,90])
                    cylinder(d=cornerDia, h=cornerWidth+overlap*2);
                translate([0,0,cornerHeight-cornerDia/2])
                    rotate([90,0,90])
                    cylinder(d=cornerDia, h=cornerWidth+overlap*2);
   
                translate([cornerWidth-10+overlap*2,-cornerDia/2,-cornerDia])
                    cube([10,10,10]);
                translate([-cornerDia/2,cornerWidth-10+overlap*2,-cornerDia])
                    cube([10,10,10]);
                translate([cornerWidth-10+overlap*2,cornerWidth-10+overlap*2,
                        -cornerDia])
                    cube([10,10,10]);
                translate([cornerWidth-10+overlap*2,cornerWidth-10+overlap*2,
                        cornerHeight-10])
                    cube([10,10,10]);
            }
        }

    }
}