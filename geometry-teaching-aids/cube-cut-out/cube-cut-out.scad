$fn=64;

size=90; 

module magnet_hole(){
    cylinder(h=1.5, d=4.2); 
}

module big_cube(){
  difference(){
    cube([size, size, size]);
    translate([size-size/3, size-size/3, size-size/3])
      cube([size/3+1, size/3+1, size/3+1]);
    translate([size/3*2 + size/3/2, size/3*2 + size/3/2, size/3*2-1.4]) magnet_hole();
    translate([size/3*2 + size/3/2, size/3*2-1.4, size/3*2 + size/3/2]) 
      rotate(a=[270,0,0]) magnet_hole();
    translate([size/3*2-1.4, size/3*2 + size/3/2, size/3*2 + size/3/2]) 
      rotate(a=[0,90,0]) magnet_hole();
  }
}

module small_cube(){
  difference(){
    cube([size/3, size/3, size/3]);
    translate([size/3/2, size/3/2, 0]) magnet_hole();
    translate([size/3/2, 0, size/3/2]) 
      rotate(a=[270,0,0]) magnet_hole();
    translate([0, size/3/2, size/3/2]) 
      rotate(a=[0,90,0]) magnet_hole();
  }
}

module main(){
  //small_cube();
  big_cube();
}

main();
