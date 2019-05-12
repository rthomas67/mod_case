// mod-case
// opening corner

devCornerDia=10;
devCornerHeight=40;
devCornerWidth=50;

devVerticalRodDia=8;
devHorizontalRodDia=6;

devSideBlockLength=120;

devPostHeight=80;

devPanelThickness=2.5;

$fn=50;
overlap=0.01;


translate([0,0,devCornerHeight])
    mirror([0,0,1]) {
        translate([-devCornerWidth,0,0])
            cornerBlock(devCornerDia,devCornerHeight,devCornerWidth,devPanelThickness,
                    devVerticalRodDia,devHorizontalRodDia,
                    true,true);
        translate([devCornerWidth+devSideBlockLength,0,0])
            mirror([1,0,0])
                cornerBlock(devCornerDia,devCornerHeight,devCornerWidth,devPanelThickness,
                    devVerticalRodDia,devHorizontalRodDia,
                    false,true);
        sideBlock(devCornerDia,devCornerHeight,devCornerWidth,devSideBlockLength,
            devPanelThickness,devHorizontalRodDia,true,false);
    }            


translate([devSideBlockLength+devCornerWidth,0,devCornerHeight])
    rotate([0,0,90])
    cornerPost(devCornerDia,devPostHeight,devCornerWidth,
        devPanelThickness,devVerticalRodDia,devHorizontalRodDia);

function horizontalSlotInset(blockWidth) = blockWidth/4;

function verticalSlotDepth(panelThickness) = panelThickness*3;

function verticalSlotCornerInset(cornerWidth) = cornerWidth/3;

function sideFaceWidth(cornerDia) = cornerDia*2;

function verticalRodInset(cornerDia, verticalRodDia, horizontalRodDia)
        = verticalRodDia/2+cornerDia+horizontalRodDia;

module sideBlock(cornerDia,sideBlockHeight,sideBlockWidth,sideBlockLength,
        panelThickness,horizontalRodDia,
        roundedCorner,reverseHoles) {
    difference() {
        hull() {
            if (roundedCorner) {
                // vertical corner at 0,0
                cube([1,1,sideBlockHeight-cornerDia]);
                // vertical corner at sideBlockLength,0
                translate([sideBlockLength-1,0,0])
                    cube([1,1,sideBlockHeight-cornerDia]);
                // top corner along x-axis
                translate([0,cornerDia/2,sideBlockHeight-cornerDia/2])
                    rotate([0,90,0])
                    cylinder(d=cornerDia,h=sideBlockLength);
            } else {
                // just the outer side (minimum block "depth" will be 1+1=2)
                cube([sideBlockLength,1,sideBlockHeight]);
            }
            // back side (surface toward inside of box/case
            translate([0,sideFaceWidth(cornerDia)-1,0])
                cube([sideBlockLength,1,sideBlockHeight]);
        }
        // horizontal rod hole X
        xHoleHeightOffset = (reverseHoles) ? horizontalRodDia : -horizontalRodDia;
        translate([0,cornerDia,sideBlockHeight/2+xHoleHeightOffset])
            rotate([0,90,0])
                countersunkHole(horizontalRodDia, sideBlockLength, false);
        
        // horizontal slot only on rounded corner piece
        if (roundedCorner) {
            translate([-overlap,horizontalSlotInset(sideBlockWidth),
                    sideBlockHeight-panelThickness*3])
            cube([sideBlockLength+overlap*2,sideBlockWidth/4+overlap,panelThickness]);
        }

        // vertical slot
        translate([-overlap,panelThickness*2,-overlap])
            cube([sideBlockLength+overlap*2,panelThickness,
                verticalSlotDepth(panelThickness)+overlap]);

    }    
}

module cornerPost(cornerDia,postHeight,cornerWidth,
        panelThickness,verticalRodDia,horizontalRodDia) {
    difference() {
        hull() {
            translate([cornerDia/2,cornerDia/2,0])
                cylinder(d=cornerDia,h=postHeight);
            translate([0,cornerWidth-1,0])
                cube([sideFaceWidth(cornerDia),1,postHeight]);
            translate([cornerWidth-1,0,0])
                cube([1,sideFaceWidth(cornerDia),postHeight]);
        }
        // vertical hole
        translate([verticalRodInset(cornerDia,verticalRodDia,horizontalRodDia),
                verticalRodInset(cornerDia, verticalRodDia, horizontalRodDia),0])
            countersunkHole(verticalRodDia,postHeight,true);
        // slot X
        translate([verticalSlotCornerInset(cornerWidth),panelThickness*2,-overlap])
            cube([cornerWidth-verticalSlotCornerInset(cornerWidth)+overlap,
                panelThickness,postHeight+overlap*2]);
        
        // slot Y
        translate([panelThickness*2,verticalSlotCornerInset(cornerWidth),-overlap])
            cube([panelThickness,cornerWidth-verticalSlotCornerInset(cornerWidth)+overlap,
                    postHeight+overlap*2]);

    }        
}


/*
 * vertical slots are placed panelThickness*2 in from the outer edge
 * horizontal slots (on roundedCorner pieces) are placed panelThickness*2
 *    in from the top/bottom (outer) edge
 */
module cornerBlock(cornerDia,cornerHeight,cornerWidth,
        panelThickness,
        verticalRodDia,horizontalRodDia,
        roundedCorner,reverseHoles) {
    difference() {
        hull() {
            if (roundedCorner) {
                translate([cornerDia/2,cornerDia/2,0])
                    cylinder(d=cornerDia, h=cornerHeight-cornerDia/2);
                translate([cornerDia/2,cornerDia/2,cornerHeight-cornerDia/2])
                    sphere(d=cornerDia);
                // top corner along y-axis
                translate([cornerDia/2,cornerWidth-cornerDia,0])
                    cube([sideFaceWidth(cornerDia)-cornerDia/2,cornerDia,cornerHeight]);
                translate([0,cornerWidth-cornerDia,0])
                    cube([sideFaceWidth(cornerDia)-cornerDia/2,cornerDia,
                        cornerHeight-cornerDia/2]);
                translate([cornerDia/2,cornerDia/2,cornerHeight-cornerDia/2])
                    rotate([-90,0,0])
                    cylinder(d=cornerDia,h=cornerWidth-cornerDia/2);
                
                // top corner along x-axis
                translate([cornerWidth-cornerDia,cornerDia/2,0])
                    cube([cornerDia,sideFaceWidth(cornerDia)-cornerDia/2,
                        cornerHeight]);
                translate([cornerWidth-cornerDia,0,0])
                    cube([cornerDia,sideFaceWidth(cornerDia)-cornerDia/2,
                        cornerHeight-cornerDia/2]);
                translate([cornerDia/2,cornerDia/2,cornerHeight-cornerDia/2])
                    rotate([0,90,0])
                    cylinder(d=cornerDia,h=cornerWidth-cornerDia/2);
            } else {
                translate([cornerDia/2,cornerDia/2,0])
                    cylinder(d=cornerDia, h=cornerHeight);
                translate([0,cornerWidth-cornerDia,0])
                    cube([sideFaceWidth(cornerDia),cornerDia,cornerHeight]);
                translate([cornerWidth-cornerDia,0,0])
                    cube([cornerDia,sideFaceWidth(cornerDia),cornerHeight]);
            }
        }
        // vertical rod hole
        translate([verticalRodInset(cornerDia, verticalRodDia, horizontalRodDia),
                verticalRodInset(cornerDia, verticalRodDia, horizontalRodDia),0])
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
        translate([verticalSlotCornerInset(cornerWidth),panelThickness*2,-overlap])
            cube([cornerWidth-verticalSlotCornerInset(cornerWidth)+overlap,
                panelThickness,verticalSlotDepth(panelThickness)+overlap]);
        
        // slot Y
        translate([panelThickness*2,verticalSlotCornerInset(cornerWidth),-overlap])
            cube([panelThickness,cornerWidth-verticalSlotCornerInset(cornerWidth)+overlap,
                    verticalSlotDepth(panelThickness)+overlap]);
            
        // horizontal slot
        if (roundedCorner) {
            translate([horizontalSlotInset(cornerWidth),horizontalSlotInset(cornerWidth),
                    cornerHeight-panelThickness*3])
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