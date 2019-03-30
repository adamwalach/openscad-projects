$fn=64;

width=54;
baseLenght=40;

dividerThickness=2;
dividerHeight=51;

baseFloorThickness=2;
baseWallThickness=3;
baseBridgeWidth=4;
baseHeight=15;


module divider(){
  difference(){
    translate([0, baseLenght/2-dividerThickness/2, 0])
      color("red")
      cube([width, dividerThickness-0.2,  dividerHeight]);

    cube([baseBridgeWidth, baseLenght, baseFloorThickness]);
    translate([width-baseBridgeWidth, 0, 0])
       cube([baseBridgeWidth, baseLenght, baseFloorThickness]);
  }
}

module base(){
    cube([baseBridgeWidth, baseLenght, baseFloorThickness]);
    translate([width-baseBridgeWidth, 0, 0])
       cube([baseBridgeWidth, baseLenght, baseFloorThickness]);
  
    translate([0, baseLenght/2-baseWallThickness-dividerThickness/2, 0])
       cube([width, baseWallThickness,  baseWallThickness+baseHeight]);
    translate([0, baseLenght/2+dividerThickness/2, 0])
       cube([width, baseWallThickness,  baseWallThickness+baseHeight]);     
  
  
    translate([0, 0, 0])
       cube([width, baseLenght/2-dividerThickness/2,  baseFloorThickness]);
    translate([0, baseLenght/2+dividerThickness/2, 0])
       cube([width, baseLenght/2-dividerThickness/2,  baseFloorThickness]);
    /*
    difference(){
    translate([0, 0, 0])
      cube([width, baseLenght/2-dividerThickness/2,  baseThickness+baseHeight]);
  
      translate([0,-7,22]) 
        rotate([0,90,0])
          linear_extrude(height=width+1)
            circle(d=40);
    }
    */
      
    
}

module main(){
    base();
    //divider();
}

main();