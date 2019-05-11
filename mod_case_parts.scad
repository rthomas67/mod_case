// mod-case
// opening corner

devCornerDia=10;
devCornerHeight=40;
devCornerWidth=50;

verticalRodDia=8;
horizontalRodDia=6;

devPanelThickness=2.5;

$fn=50;
overlap=0.01;

cornerBlock(devCornerDia,devCornerHeight,devCornerWidth,devPanelThickness,true,true);

/*
 * vertical slots are placed panelThickness*2 in from the outer edge
 * horizontal slots (on roundedCorner pieces) are placed panelThickness*2
 *    in from the top/bottom (outer) edge
 */
module cornerBlock(cornerDia,cornerHeight,cornerWidth,
        panelThickness,roundedCorner,reverseHoles) {
    slotDepth=panelThickness*3;
    difference() {
        hull() {
            if (roundedCorner) {
                translate([cornerDia/2,cornerDia/2,0])
                    cylinder(d=cornerDia, h=cornerHeight-cornerDia/2);
                translate([cornerDia/2,cornerDia/2,cornerHeight-cornerDia/2])
                    sphere(d=cornerDia);
                // top corner along y-axis
                translate([cornerDia/2,cornerWidth-cornerDia,0])
                    cube([cornerDia*1.5,cornerDia,cornerHeight]);
                translate([0,cornerWidth-cornerDia,0])
                    cube([cornerDia*1.5,cornerDia,cornerHeight-cornerDia/2]);
                translate([cornerDia/2,cornerDia/2,cornerHeight-cornerDia/2])
                    rotate([-90,0,0])
                    cylinder(d=cornerDia,h=cornerWidth-cornerDia/2);
                
                // top corner along x-axis
                translate([cornerWidth-cornerDia,cornerDia/2,0])
                    cube([cornerDia,cornerDia*1.5,cornerHeight]);
                translate([cornerWidth-cornerDia,0,0])
                    cube([cornerDia,cornerDia*1.5,cornerHeight-cornerDia/2]);
                translate([cornerDia/2,cornerDia/2,cornerHeight-cornerDia/2])
                    rotate([0,90,0])
                    cylinder(d=cornerDia,h=cornerWidth-cornerDia/2);
            } else {
                translate([cornerDia/2,cornerDia/2,0])
                    cylinder(d=cornerDia, h=cornerHeight);
                translate([0,cornerWidth-cornerDia,0])
                    cube([cornerDia*2,cornerDia,cornerHeight]);
                translate([cornerWidth-cornerDia,0,0])
                    cube([cornerDia,cornerDia*2,cornerHeight]);
            }
        }
        // vertical rod hole
        translate([verticalRodDia/2+cornerDia+horizontalRodDia,
                verticalRodDia/2+cornerDia+horizontalRodDia,0])
            countersunkHole(verticalRodDia,cornerHeight,true);
        xHoleHeightOffset = (reverseHoles) ? -horizontalRodDia : horizontalRodDia;
        yHoleHeightOffset = (reverseHoles) ? horizontalRodDia : -horizontalRodDia;
        // horizontal rod hole X
        translate([0,cornerDia,cornerHeight/2+xHoleHeightOffset])
            rotate([0,90,0])
                countersunkHole(horizontalRodDia, cornerWidth+cornerDia*1.5, false);
        // horizontal rod hole Y
        translate([cornerDia,0,cornerHeight/2+yHoleHeightOffset])
            rotate([-90,0,0])
                countersunkHole(horizontalRodDia, cornerWidth+cornerDia*1.5, false);
        
        // slot X
        translate([cornerWidth/3+overlap,panelThickness*2,-overlap])
            cube([cornerWidth*2/3,panelThickness,slotDepth+overlap]);
        
        // slot Y
        translate([panelThickness*2,cornerWidth/3+overlap,-overlap])
            cube([panelThickness,cornerWidth*2/3,slotDepth+overlap]);
            
        if (roundedCorner) {
            translate([cornerWidth/4,cornerWidth/4,cornerHeight-panelThickness*3])
            difference() {
                cube([cornerWidth*3/4+overlap,cornerWidth*3/4+overlap,panelThickness+overlap]);
                rotate([0,0,45])
                    translate([-cornerWidth/3,-cornerWidth/3,-overlap])
                        cube([cornerWidth*2/3,cornerWidth*2/3,panelThickness+overlap*2]);
            }
        }    
    }

}

// note: this returns already overlapped and re-positioned
module countersunkHole(holeDia, holeLength, countersinkAtTop) {
    translate([0,0,-overlap])
        union() {
            cylinder(d=holeDia, h=holeLength+overlap*2);
            if (countersinkAtTop) {
                translate([0,0,holeLength-holeDia/2+overlap])
                    cylinder(d=holeDia*2, h=holeDia/2+overlap);
            } else {
                translate([0,0,-overlap])
                    cylinder(d=holeDia*2, h=holeDia/2+overlap);
            }
        }
}