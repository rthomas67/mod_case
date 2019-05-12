use <mod_case_parts.scad>

cornerDia=10;
cornerHeight=40;
cornerWidth=50;
lowerHeight=250;
upperHeight=150;


verticalRodDia=8;
horizontalRodDia=6;

width=800;  // outer
depth=350;  // outer

sideBlockCountOnWideSide=3;
sideBlockCountOnDeepSide=2;

sideBlockLengthOnWideSide=(width-cornerWidth*2)/sideBlockCountOnWideSide;
sideBlockLengthOnDeepSide=(depth-cornerWidth*2)/sideBlockCountOnDeepSide;

lowerCornerPostCount=2;
upperCornerPostCount=1;

lowerCornerPostHeight=(lowerHeight-cornerHeight*2)/lowerCornerPostCount;
upperCornerPostHeight=(upperHeight-cornerHeight*2)/upperCornerPostCount;


openingGap=1;

panelThickness=2.5;

// bottom
translate([0,0,cornerHeight]) {
    mirror([0,0,1]) {
        translate([0,0,0]) 
            cornerBlock(cornerDia,cornerHeight,cornerWidth,panelThickness,
                verticalRodDia,horizontalRodDia,
                true,false);
            
        translate([width,0,0])
            mirror([1,0,0])
            cornerBlock(cornerDia,cornerHeight,cornerWidth,panelThickness,
                verticalRodDia,horizontalRodDia,
                true,false);
            
        translate([width,depth,0])
            mirror([1,1,0])
            cornerBlock(cornerDia,cornerHeight,cornerWidth,panelThickness,
                verticalRodDia,horizontalRodDia,
                true,true);
            
        translate([0,depth,0])
            mirror([0,1,0])
            cornerBlock(cornerDia,cornerHeight,cornerWidth,panelThickness,
                verticalRodDia,horizontalRodDia,
                true,false);

        // side blocks
        sideBlocksX(sideBlockCountOnWideSide,sideBlockLengthOnWideSide,true);
        sideBlocksY(sideBlockCountOnDeepSide,sideBlockLengthOnDeepSide,true);
    }  // end z-mirror
    // lower side posts
    cornerPosts(lowerCornerPostCount, lowerCornerPostHeight);
    // upper side posts
    translate([0,0,lowerHeight+openingGap])
    cornerPosts(upperCornerPostCount, upperCornerPostHeight);
}

// top
translate([0,0,lowerHeight+openingGap+upperHeight-cornerHeight]) {
    translate([0,0,0]) 
        cornerBlock(cornerDia,cornerHeight,cornerWidth,panelThickness,
                verticalRodDia,horizontalRodDia,
                true,false);
        
    translate([width,0,0])
        mirror([1,0,0])
        cornerBlock(cornerDia,cornerHeight,cornerWidth,panelThickness,
                verticalRodDia,horizontalRodDia,
                true,false);
        
    translate([width,depth,0])
        mirror([1,1,0])
        cornerBlock(cornerDia,cornerHeight,cornerWidth,panelThickness,
                verticalRodDia,horizontalRodDia,
                true,true);
        
    translate([0,depth,0])
        mirror([0,1,0])
        cornerBlock(cornerDia,cornerHeight,cornerWidth,panelThickness,
                verticalRodDia,horizontalRodDia,
                true,false);    

    // side blocks
    sideBlocksX(sideBlockCountOnWideSide,sideBlockLengthOnWideSide,true);
    sideBlocksY(sideBlockCountOnDeepSide,sideBlockLengthOnDeepSide,true);
}

// lower half opening/hinge corner blocks
translate([0,0,lowerHeight-cornerHeight]) {
    translate([0,0,0]) 
        cornerBlock(cornerDia,cornerHeight,cornerWidth,panelThickness,
                verticalRodDia,horizontalRodDia,
                false,false);
        
    translate([width,0,0])
        mirror([1,0,0])
        cornerBlock(cornerDia,cornerHeight,cornerWidth,panelThickness,
                verticalRodDia,horizontalRodDia,
                false,false);
        
    translate([width,depth,0])
        mirror([1,1,0])
        cornerBlock(cornerDia,cornerHeight,cornerWidth,panelThickness,
                verticalRodDia,horizontalRodDia,
                false,true);
        
    translate([0,depth,0])
        mirror([0,1,0])
        cornerBlock(cornerDia,cornerHeight,cornerWidth,panelThickness,
                verticalRodDia,horizontalRodDia,
                false,false);    

    // side blocks
    sideBlocksX(sideBlockCountOnWideSide,sideBlockLengthOnWideSide,false);
    sideBlocksY(sideBlockCountOnDeepSide,sideBlockLengthOnDeepSide,false);
}    

// upper half opening/hinge corner blocks
translate([0,0,lowerHeight+cornerHeight+openingGap]) {
    mirror([0,0,1]) {
        translate([0,0,0]) 
            cornerBlock(cornerDia,cornerHeight,cornerWidth, panelThickness,
                verticalRodDia,horizontalRodDia,
                false,false);
            
        translate([width,0,0])
            mirror([1,0,0])
            cornerBlock(cornerDia,cornerHeight,cornerWidth, panelThickness,
                verticalRodDia,horizontalRodDia,
                false,false);
            
        translate([width,depth,0])
            mirror([1,1,0])
            cornerBlock(cornerDia,cornerHeight,cornerWidth, panelThickness,
                verticalRodDia,horizontalRodDia,
                false,true);
            
        translate([0,depth,0])
            mirror([0,1,0])
            cornerBlock(cornerDia,cornerHeight,cornerWidth, panelThickness,
                verticalRodDia,horizontalRodDia,
                false,false);        
        // side blocks
        sideBlocksX(sideBlockCountOnWideSide,sideBlockLengthOnWideSide,false);
        sideBlocksY(sideBlockCountOnDeepSide,sideBlockLengthOnDeepSide,false);
    }
}

// panels
% translate([cornerDia*1.5,cornerDia*1.5,panelThickness*2])
   cube([width-cornerDia*3,depth-cornerDia*3,panelThickness]);
% translate([cornerDia*1.5,cornerDia*1.5,lowerHeight+upperHeight+openingGap-panelThickness*3])
   cube([width-cornerDia*3,depth-cornerDia*3,panelThickness]);

% translate([0,0,cornerHeight-verticalSlotDepth(panelThickness)])
    sidePanels(lowerHeight-cornerHeight*1.5);
% translate([0,0,lowerHeight+openingGap+cornerHeight-verticalSlotDepth(panelThickness)])
    sidePanels(upperHeight-cornerHeight*1.5);

module sidePanels(panelHeight) {
    translate([verticalSlotCornerInset(cornerWidth),panelThickness*2,0])
       cube([width-verticalSlotCornerInset(cornerWidth)*2,panelThickness,panelHeight]);
    translate([verticalSlotCornerInset(cornerWidth),depth-panelThickness*3,0])
       cube([width-verticalSlotCornerInset(cornerWidth)*2,panelThickness,panelHeight]);
    translate([panelThickness*2,verticalSlotCornerInset(cornerWidth),0])
       cube([panelThickness,depth-verticalSlotCornerInset(cornerWidth)*2,panelHeight]);
    translate([width-panelThickness*3,verticalSlotCornerInset(cornerWidth),0])
       cube([panelThickness,depth-verticalSlotCornerInset(cornerWidth)*2,panelHeight]);
}

module cornerPosts(postCount,postHeight) {
    for (i=[0:1:postCount-1]) {
        translate([0,0,i*postHeight]) {
            cornerPost(cornerDia,postHeight,cornerWidth,panelThickness,
                            verticalRodDia,horizontalRodDia);
            translate([width,0,0]) rotate([0,0,90])
            cornerPost(cornerDia,postHeight,cornerWidth,panelThickness,
                            verticalRodDia,horizontalRodDia);
            translate([width,depth,0]) rotate([0,0,180])
            cornerPost(cornerDia,postHeight,cornerWidth,panelThickness,
                            verticalRodDia,horizontalRodDia);
            translate([0,depth,0]) rotate([0,0,270])
            cornerPost(cornerDia,postHeight,cornerWidth,panelThickness,
                            verticalRodDia,horizontalRodDia);
        }
    }
}

module sideBlocksX(blockCount,blockLength,roundedCorner) {
    for (i=[0:1:blockCount-1]) {
        translate([cornerWidth+i*blockLength,0,0])
            mirror([0,0,0])
                sideBlock(cornerDia,cornerHeight,cornerWidth,blockLength,
                    panelThickness,
                    horizontalRodDia,
                    roundedCorner,true);
        translate([cornerWidth+i*blockLength,depth,0])
            mirror([0,1,0])
                sideBlock(cornerDia,cornerHeight,cornerWidth,blockLength,
                    panelThickness,
                    horizontalRodDia,
                    roundedCorner,true);
    }
}

module sideBlocksY(blockCount,blockLength,roundedCorner) {
    for (i=[0:1:blockCount-1]) {
        translate([0,cornerWidth+i*blockLength,0])
            mirror([1,0,0])
            rotate([0,0,90])
                sideBlock(cornerDia,cornerHeight,cornerWidth,blockLength,
                    panelThickness,
                    horizontalRodDia,
                    roundedCorner,false);
        translate([width,cornerWidth+i*blockLength,0])
            rotate([0,0,90])
                sideBlock(cornerDia,cornerHeight,cornerWidth,blockLength,
                    panelThickness,
                    horizontalRodDia,
                    roundedCorner,false);
    }
}
