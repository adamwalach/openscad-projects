$fn=64;

sphereDiameter = 100;

mHoleDepth = 1.5;
mHoleDiameter = 4.1;
mHoleMargin = 20;

module mHole(){
  rotate([90,90,0])
    cylinder(
      h = mHoleDepth, 
      d1 = mHoleDiameter,
      d2 = mHoleDiameter,
      center = false);
}

module main(){
  difference(){
    sphere(d = sphereDiameter,
        center = false);

    translate([0, sphereDiameter/2, 0])
      cube([sphereDiameter, sphereDiameter, sphereDiameter+2], center=true);
    
    //bottom
    margin = sphereDiameter/2 - mHoleMargin;
    translate([margin, 0.1, margin]) mHole();
    translate([-margin, 0.1, margin]) mHole();

    //top
    translate([margin, 0.1, -margin]) mHole();
    translate([-margin, 0.1, -margin]) mHole();
  }
}

main();
