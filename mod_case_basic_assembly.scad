use <mod_case_parts.scad>

cornerDia=10;
cornerHeight=40;
cornerWidth=50;
lowerHeight=250;
upperHeight=200;
width=600;
depth=350;
openingGap=1;

panelThickness=2.5;

// bottom
translate([0,0,cornerHeight]) {
    mirror([0,0,1]) {
        translate([0,0,0]) 
            cornerBlock(cornerDia,cornerHeight,cornerWidth, panelThickness,true);
            
        translate([width,0,0])
            mirror([1,0,0])
            cornerBlock(cornerDia,cornerHeight,cornerWidth, panelThickness,true);
            
        translate([width,depth,0])
            mirror([1,1,0])
            cornerBlock(cornerDia,cornerHeight,cornerWidth, panelThickness,true,true);
            
        translate([0,depth,0])
            mirror([0,1,0])
            cornerBlock(cornerDia,cornerHeight,cornerWidth, panelThickness,true);    
    }
}

// top
translate([0,0,lowerHeight+openingGap+upperHeight-cornerHeight]) {
    translate([0,0,0]) 
        cornerBlock(cornerDia,cornerHeight,cornerWidth, panelThickness,true);
        
    translate([width,0,0])
        mirror([1,0,0])
        cornerBlock(cornerDia,cornerHeight,cornerWidth, panelThickness,true);
        
    translate([width,depth,0])
        mirror([1,1,0])
        cornerBlock(cornerDia,cornerHeight,cornerWidth, panelThickness,true,true);
        
    translate([0,depth,0])
        mirror([0,1,0])
        cornerBlock(cornerDia,cornerHeight,cornerWidth, panelThickness,true);    
}

// lower half opening/hinge corner blocks
translate([0,0,lowerHeight-cornerHeight]) {
    translate([0,0,0]) 
        cornerBlock(cornerDia,cornerHeight,cornerWidth,panelThickness,false);
        
    translate([width,0,0])
        mirror([1,0,0])
        cornerBlock(cornerDia,cornerHeight,cornerWidth,panelThickness,false);
        
    translate([width,depth,0])
        mirror([1,1,0])
        cornerBlock(cornerDia,cornerHeight,cornerWidth,panelThickness,false,true);
        
    translate([0,depth,0])
        mirror([0,1,0])
        cornerBlock(cornerDia,cornerHeight,cornerWidth,panelThickness,false);    
}    
// upper half opening/hinge corner blocks
translate([0,0,openingGap]) {
    translate([0,0,lowerHeight+cornerHeight]) 
        mirror([0,0,1])
        cornerBlock(cornerDia,cornerHeight,cornerWidth, panelThickness,false);
        
    translate([width,0,lowerHeight+cornerHeight])
        mirror([0,0,1])
        mirror([1,0,0])
        cornerBlock(cornerDia,cornerHeight,cornerWidth, panelThickness,false);
        
    translate([width,depth,lowerHeight+cornerHeight])
        mirror([0,0,1])
        mirror([1,1,0])
        cornerBlock(cornerDia,cornerHeight,cornerWidth, panelThickness,false,true);
        
    translate([0,depth,lowerHeight+cornerHeight])
        mirror([0,0,1])
        mirror([0,1,0])
        cornerBlock(cornerDia,cornerHeight,cornerWidth, panelThickness,false);        
}

// panels
% translate([cornerDia,cornerDia,panelThickness*2])
   cube([width-cornerDia*2,depth-cornerDia/2,panelThickness]);