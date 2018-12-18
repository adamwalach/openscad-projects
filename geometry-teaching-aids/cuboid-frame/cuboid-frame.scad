$fn=64;

height=50;
width=70;
length=100;
thickness=5;
hSize=2.5;
hLen=thickness*3;

latchLen=7;

module holes(){
  //top
  //corners
  translate([0, 0, height+hSize/2]) rotate([0,  135 , 45]) cylinder (d=hSize, h=hLen);
  translate([width, 0, height+hSize/2]) rotate([-135, 0, 45]) cylinder (d=hSize, h=hLen);
  translate([0, length, height+hSize/2]) rotate([0,  135 , -45]) cylinder (d=hSize, h=hLen);
  translate([width, length, height+hSize/2]) rotate([0, -135, 45]) cylinder (d=hSize, h=hLen);
  //middle
  translate([width/2, 0, height+hSize/2]) rotate([-140, 0 ,0]) cylinder (d=hSize, h=hLen);
  translate([0, length/2, height+hSize/2]) rotate([0, 140 ,0]) cylinder (d=hSize, h=hLen);
  translate([width, length/2, height+hSize/2]) rotate([0, -140 ,0]) cylinder (d=hSize, h=hLen);
  translate([width/2, length, height+hSize/2]) rotate([140, 0 ,0]) cylinder (d=hSize, h=hLen);
  
  //bottom
  //corners
  translate([0, 0, -hSize/2]) rotate([0,  45 , 45]) cylinder (d=hSize, h=hLen);
  translate([width, 0, -hSize/2]) rotate([-45, 0, 45]) cylinder (d=hSize, h=hLen);
  translate([0, length, -hSize/2]) rotate([0,  45 , -45]) cylinder (d=hSize, h=hLen);
  translate([width, length, -hSize/2]) rotate([0, -45, 45]) cylinder (d=hSize, h=hLen);
  //middle
  translate([width/2, 0, -hSize/2]) rotate([-40, 0, 0]) cylinder (d=hSize, h=hLen);
  translate([0, length/2, -hSize/2]) rotate([0, 40, 0]) cylinder (d=hSize, h=hLen);
  translate([width, length/2, -hSize/2]) rotate([0, -40, 0]) cylinder (d=hSize, h=hLen);
  translate([width/2, length, -hSize/2]) rotate([40, 0, 0]) cylinder (d=hSize, h=hLen);
}

module cuboid() {
  union(){
    difference() {
      translate([0.01, 0.01, 0.01])
        cube([width, length, height]); //front wall
      
      translate([0, thickness, thickness])
        color("red") cube([width+10, length-thickness*2, height-thickness*2]);
      translate([thickness, 0, thickness])
        color("green") cube([width-thickness*2, length+10, height-thickness*2]);
      translate([thickness, thickness, 0])
        color("blue") cube([width-thickness*2, length-thickness*2, height+10]);   
      holes();
    }    
  }
}

module upperPart(){
  pinH=latchLen-2;
  pinD=3;
  union(){
    difference(){
      cuboid();
      cube([width+1, length+1, height/2]);
    }
    translate([thickness/2, thickness/2, height/2-pinH+0.01]) cylinder (d=pinD, h=pinH); 
    translate([width-thickness/2, thickness/2, height/2-pinH+0.01]) cylinder (d=pinD, h=pinH); 
    translate([width-thickness/2, length-thickness/2, height/2-pinH+0.01]) cylinder (d=pinD, h=pinH); 
    translate([thickness/2, length-thickness/2, height/2-pinH+0.01]) cylinder (d=pinD, h=pinH); 
  }
}

module bottomPart(){
  holeH=latchLen;
  holeD=3.4;
  difference(){
    cuboid();
    translate([0,0,height/2])
      cube([width+1, length+1, height]);
      translate([thickness/2, thickness/2, height/2-holeH+0.01]) cylinder (d=holeD, h=holeH); 
      translate([width-thickness/2, thickness/2, height/2-holeH+0.01]) cylinder (d=holeD, h=holeH); 
      translate([width-thickness/2, length-thickness/2, height/2-holeH+0.01]) cylinder (d=holeD, h=holeH); 
      translate([thickness/2, length-thickness/2, height/2-holeH+0.01]) cylinder (d=holeD, h=holeH); 
  }
}

module main() {
  //upperPart();
  bottomPart();
}

main();

