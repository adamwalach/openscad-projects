$fn=32;

baseLength = 70;
height = 100;
frameThickness = 6;

// Hole diameter
hDiameter=2.5;

// Length of the cylinder that makes the hole
// not a critical value, has to be longer than frameThinckness
hLen=frameThickness*4; 

//taken from http://forum.openscad.org/Rods-between-3D-points-tp13104p13108.html
module rod(a, b, d) { 
    translate(a) sphere(d=d); 
    translate(b) sphere(d=d); 

    dir = b-a; 
    h   = norm(dir); 
    if(dir[0] == 0 && dir[1] == 0) { 
        // no transformation necessary 
        cylinder(r=r, h=h); 
    } 
    else { 
        w  = dir / h; 
        u0 = cross(w, [0,0,1]); 
        u  = u0 / norm(u0); 
        v0 = cross(w, u); 
        v  = v0 / norm(v0); 
        multmatrix(m=[[u[0], v[0], w[0], a[0]], 
                      [u[1], v[1], w[1], a[1]], 
                      [u[2], v[2], w[2], a[2]], 
                      [0,    0,    0,    1]]) 
        cylinder(d=d, h=h); 
    } 
}

module pyramid(a, b, c, d, diameter){
  union(){
      color("green") rod(a, b, diameter);
      color("red") rod(b, c, diameter);
      color("blue") rod(c, a, diameter);
      
      color("yellow") rod(a, d, diameter);
      color("white") rod(b, d, diameter);
      color("black") rod(c, d, diameter);  
  }
}

module holes(a, b, c, d, diameter, lenght){
  // ab
  translate([(a[0] + b[0])/2, (a[1] + b[1])/2, -lenght/2]) rotate([0,  0 , 45]) cylinder (d=diameter, h=lenght);
  // bc
  translate([(b[0] + c[0])/2, (b[1] + c[1])/2, -lenght/2]) rotate([0,  0 , 45]) cylinder (d=diameter, h=lenght);
  // ca 
  translate([(c[0] + a[0])/2, (c[1] + a[1])/2, -lenght/2]) rotate([0,  0 , 45]) cylinder (d=diameter, h=lenght);
  
  // top
  translate([d[0], d[1], d[2]-lenght/2]) rotate([0,  0 , 45]) cylinder (d=diameter, h=lenght);
}

module main(){
  a = [0, 0, 0];
  b = [baseLength, 0 ,0];
  c = [baseLength/2, (baseLength*sqrt(3))/2, 0];
  d = [baseLength/2, (baseLength*sqrt(3))/6, height];

  difference(){
    pyramid(a, b, c, d, frameThickness);
    holes(a, b, c, d, hDiameter, hLen);
  } 
}

main();
