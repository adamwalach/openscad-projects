//include <oshw.scad>
$fn=64;

//-------SETTINGS---------------
//---CONE-----------------------
ConeHeight = 15;
ConeBottomRadius = 1.32;
ConeTopRadius = 2.93;
//------------------------------

//---BOARD----------------------
BoardHeight = 16;
BoardThickness = 10;
WallThickness = 3;
ConeSpace = 9;
//------------------------------

//---BOARD SIZE-----------------
sizes = [
  [44.44, 42.1, 4, 4],
  [99, 114, 12, 10],
  [180, 114, 12, 19]
];

size = 0; //change me!!
ConeCountX = sizes[size][2];
ConeCountY = sizes[size][3];
BoardLength = sizes[size][1];
BoardWidth = sizes[size][0];

//------------------------------

//Part selector
LeftMargin = 3;
part = "left"; //right or left
latchEnabled = true;
wallsEnabled = false;
feetEnabled = false;
//------------------------------


module foot(){
  cylinder(
    h = BoardHeight-BoardThickness+0.1, 
    d1 = 6,
    d2 = 6,
    center = false);
}

module feet(){
  margin = 3.5;

  translate([BoardLength-margin, margin, 0]) foot();
  translate([BoardLength-margin, BoardWidth-margin, 0]) foot();

  if (part == "left"){
    translate([margin, margin, 0]) foot();
    translate([margin, BoardWidth-margin, 0]) foot(); 
  }else{
    translate([margin+8, margin, 0]) foot();
    translate([margin+8, BoardWidth-margin, 0]) foot();
  }
}

module cones(){
  for(y=[1:ConeCountY]){
    for(x=[1:ConeCountX]){
      translate([x*ConeSpace,y*ConeSpace,BoardHeight-1.1])
        cylinder(h = 1.2,
                r1 = ConeTopRadius, 
                r2 = ConeTopRadius,
                center = false);

      translate([x*ConeSpace, y*ConeSpace, BoardHeight-ConeHeight-1])
        cylinder(h = ConeHeight,
               r1 = ConeBottomRadius, 
               r2 = ConeTopRadius,
               center = false);
    }
  }    
}


module numbers(offset = 0){
  for(x=[1:ConeCountX]){
    translate([x*ConeSpace, ConeCountY*ConeSpace+4, BoardHeight])
      linear_extrude(height = 0.5){
        text(
            str(offset+x),
            font = "Verdana:style=Bold",
            size = 4,
            halign = "center");
      }
  }    
}

module letters(){
  for(y=[1:ConeCountY]){
    translate([0.8, (ConeCountY-y+1)*ConeSpace-2, BoardHeight])
      linear_extrude(height = 0.5){
          text(chr(64+y),
          font = "Verdana:style=Bold",
          size = 4);        
      }
  }
}

module grid(){
  for(x=[2:2:ConeCountX-1]){
    translate([x*ConeSpace+4,3,BoardHeight])
      cube([1,BoardWidth-6,0.5],false);
  }
  for(y=[2:2:ConeCountY-1]){
    translate([2,(ConeCountY-y+1)*ConeSpace-5,BoardHeight])
      cube([BoardLength-4,1,0.5],false);
  }
}

module latchEdging(){
 //https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language#polyhedron
  latchWidth = 3;
  latchThickness = BoardThickness-3;
  CubePoints = [
  [  0, 0, 0 ],  //0
  [ latchWidth, -3, 0 ],  //1
  [ latchWidth, 10, 0 ],  //2
  [  0, 7, 0 ],  //3
  [  0, 0, latchThickness ],  //4
  [ latchWidth, -3, latchThickness ],  //5
  [ latchWidth, 10, latchThickness ],  //6
  [  0, 7, BoardThickness-3 ]]; //7
  
  CubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
     
  translate([BoardLength, BoardWidth-15, BoardHeight-BoardThickness])
    polyhedron( CubePoints, CubeFaces );
  translate([BoardLength, 8, BoardHeight-BoardThickness])
    polyhedron( CubePoints, CubeFaces );
  if (BoardWidth > 90){
    translate([BoardLength, BoardWidth/2-15, BoardHeight-BoardThickness])
      polyhedron( CubePoints, CubeFaces );
    translate([BoardLength, BoardWidth/2+15, BoardHeight-BoardThickness])
      polyhedron( CubePoints, CubeFaces );
  }
}

module latchHole(){
  //https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language#polyhedron
  latchWidth = 3;
  latchThickness = BoardThickness-2.4;
  CubePoints = [
  [  -0.01, 0, 0 ],  //0
  [ latchWidth, -3, 0 ],  //1
  [ latchWidth, 10, 0 ],  //2
  [  -0.01, 7, 0 ],  //3
  [  -0.01, 0, latchThickness],  //4
  [ latchWidth, -3, latchThickness ],  //5
  [ latchWidth, 10, latchThickness ],  //6
  [  -0.01, 7, latchThickness ]]; //7
  
  CubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left   
  translate([LeftMargin, BoardWidth-15, BoardHeight-BoardThickness])
    polyhedron( CubePoints, CubeFaces );
  translate([LeftMargin, 8, BoardHeight-BoardThickness])
    polyhedron( CubePoints, CubeFaces );
  if (BoardWidth > 90){
    translate([LeftMargin, BoardWidth/2-15, BoardHeight-BoardThickness])
      polyhedron( CubePoints, CubeFaces );
    translate([LeftMargin, BoardWidth/2+15, BoardHeight-BoardThickness])
      polyhedron( CubePoints, CubeFaces );
  }
}

module walls(){
  translate([BoardLength, 0, 0])
    cube([WallThickness, BoardWidth, BoardHeight], false);
  translate([0, 0, 0])
    cube([WallThickness, BoardWidth, BoardHeight], false);
  translate([0, 0, 0])
    cube([BoardLength, WallThickness, BoardHeight], false);
  translate([0, BoardWidth-WallThickness, 0])
  cube([BoardLength, WallThickness, BoardHeight], false);  
}

module board(){
   union(){
     if (part=="left"){ 
       letters();
       numbers(0);
     }else{
       numbers(ConeCountX);
     }
     grid();
     if (part=="left" && latchEnabled) latchEdging();
     translate([0, 0, BoardHeight-BoardThickness])
        cube([BoardLength, BoardWidth, BoardThickness], false);
     if (wallsEnabled) walls();
   }
}


module main(){
  difference(){
    board();
    cones();
    if (feetEnabled) feet();  
    if (part=="right" && latchEnabled) latchHole();
    if (part=="right") 
      translate([-0.1,-0.1,0])
        cube([LeftMargin+0.1, BoardWidth+1, BoardHeight+1], false);
  }
}

main();
