$fn = 64;

cylHeight = 110;
cylDiameter = 100;

mHoleDepth = 1.5;
mHoleDiameter = 4.1;
mHoleMargin = 15;

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
    cylinder(h = cylHeight,
            d1 = cylDiameter,
            d2 = cylDiameter,
        center = true);

    translate([0, cylDiameter/2, 0])
      cube([cylDiameter, cylDiameter, cylHeight+2], center=true);

    //bottom
    margin=cylDiameter/2-mHoleMargin;
    translate([margin, 0.1, margin]) mHole();
    translate([-margin, 0.1, margin]) mHole();

    //top
    translate([margin, 0.1, -margin]) mHole();
    translate([-margin, 0.1, -margin])  mHole();       
  }
}

main();
