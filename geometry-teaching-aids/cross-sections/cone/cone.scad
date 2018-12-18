$fn=64;

coneHeight = 110;
coneDiameter = 100;

mHoleDepth = 1.5;
mHoleDiameter = 4.1;
mHoleMargin = 20;

module mHole(){
  rotate([90, 90, 0])
    cylinder(
      h = mHoleDepth, 
      d1 = mHoleDiameter,
      d2 = mHoleDiameter,
      center = false);
}

module main(){
  difference(){
    cylinder(h = coneHeight,
            d1 = coneDiameter,
            d2 = 0,
        center = false);

    translate([0, coneDiameter/2, coneHeight/2])
      cube([coneDiameter, coneDiameter, coneHeight+2], center=true);

    //bottom
    translate([coneDiameter/2-mHoleMargin, 0.1, 10]) mHole();
    translate([-coneDiameter/2+mHoleMargin, 0.1, 10]) mHole();

    //top
    translate([0, 0.1, coneHeight-mHoleMargin]) mHole();
  }
}

main();