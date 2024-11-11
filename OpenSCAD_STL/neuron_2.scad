
// For ssDNA or ssRNA aspect of this 
// Conscious Gate Transistor (CGT)
//.stl models of ssDNA and ssRNA, courtesy of
// Howell ME, van Dijk K and Roston RL
// "Flexible ssDNA and ssRNA models for
// classroom demonstration." 2018.
// University of Nebraska--Linclon
// michellepalmer288@gmail.com
// 3dprint.nih.gov/discover/3DPX-0088800

// All other code was created by Jerry D. Harthcock, which you can download, copy, edit, modify and distribute freely for non-commercial use.




//// This code can be used to create a realistic ZiZag CNT in 10nm increments
//// Be careful to keep L <= 10, otherwise the resulting structure will consume all your memory and take forever to render
module tubeZigZag_Lx10_plus_1nm(){
L=4;
for (i=[0:1:4]) {    //50nm
translate ([(10.35*i),0,0])
rotate([0,90,0])
 import("CNT_6_0_10nm.stl");
}   
}

//// This code can be used to create a realistic ZiZag CNT in 10nm increments
//// Be careful to keep L <= 10, otherwise the resulting structure will consume all your memory and take forever to render
module tubeArmChair_Lx10_plus_1nm(){
L=4;
for (i=[0:1:4]) {    //50nm
translate ([(10.35*i),0,0])
rotate([0,90,0])
 import("CNT_6_6_10nm.stl");
}   
}


//// This module is used to create the dendrites and axon using standard solid cylinder, which renders exponentially faster than the realistic armchair or tubeZigZag versions CNT_6_6_10nm.stl or CNT_6_0_10nm.stl using the above modules

module modelSpokes(){
for(i=[0:30:330]){
rotate([0,0,i])
if (i==330 || i==30 || i==60) {}
else if (i==0) translate([18.1,0,0]) rotate([0,0,10]) translate([26,0,0]) rotate([0,90,0])
 cylinder(h=52, d1=1.494, d2=1.494, $fn=18, center=true);
else translate([18.1,0,0]) rotate([0,0,-30]) translate([26,0,0]) rotate([0,90,0])
 cylinder(h=52, d1=1.494, d2=1.494, $fn=18, center=true);
}
} 
//// This module constructs the dendrites and axon on-the-fly and therefore takes longer than simply importing the pre-made .STL of them--so comment out the one of the two versions below you least prefer

module spokes(){
for(i=[0:30:330]){
rotate([0,0,i])
if (i==330 || i==30 || i==60) {}
else if (i==0) translate([18.1,0,0]) rotate([0,0,10]) tubeZigZag_Lx10_plus_1nm();  //axon
else translate([18.1,0,0]) rotate([0,0,-30]) tubeZigZag_Lx10_plus_1nm();  //dendrite
}
}


//// this module imports a pre-constructed 50nm armchair nanotube, which is significantly faster to render than the version above
/*
module spokes(){
for(i=[0:30:330]){
rotate([0,0,i])
if (i==330 || i==30 || i==60) {}
else if (i==0) translate([18.1,0,0]) rotate([0,0,10]) import("tube_constr_manual.stl");  //axon
else translate([18.1,0,0]) rotate([0,0,-30]) import("tube_constr_manual.stl");  //dendrite
}
}
*/

// This is used as the image to be subtracted from from the substrate to create the trenches in which the dendrite and axon CNTs rest
module squareSpokes(){
for(i=[0:30:330]){
rotate([0,0,i])
if (i==330 || i==30 || i==60) {}
else if (i==0) translate([18.1,0,0]) rotate([0,0,10]) //axon
translate([29,0,0]) rotate([0,90,0])
 //cylinder(h=104, d1=1.494, d2=1.494, $fn=18, center=true);

union(){
 cube ([2.0, 2.0, 56], center=true);
 translate ([0,-2.5, -4.7]) cube ([2.0, 2.0, 45.5], center=true);  
  translate ([0,-7.5, 2]) rotate([18,0,0]) cube ([2.0, 2.0, 32], center=true);   
}
else translate([18.1,0,0]) rotate([0,0,-30]) //dendrite
translate([29,0,0]) rotate([0,90,0])
 //cylinder(h=104, d1=1.494, d2=1.494, $fn=18, center=true);
union(){
 cube ([2.0, 2.0, 56], center=true);
 translate ([0,2.5, -4.7]) cube ([2.0, 2.0, 45.5], center=true);  
  translate ([0,7.5, 5]) rotate([-18,0,0]) cube ([2.0, 2.0, 32], center=true);   
   
}
}
}

module fields(){
for(i=[0:30:330]){
rotate([0,0,i])
if (i==330 || i==30 || i==60) {}
else if (i==0) //axon
    translate([18.1,0,0]) rotate([0,0,10]) 
translate([29,0,0]) rotate([0,90,0])
union(){
 translate ([0,-2.5, -4.7]) cube ([2.0, 2.0, 45.5], center=true);  
  translate ([0,-7.5, 2]) rotate([18,0,0]) cube ([2.0, 2.0, 32], center=true); 
    }
    
else translate([18.1,0,0]) rotate([0,0,-30]) //dendrite
translate([29,0,0]) rotate([0,90,0])
union(){
 translate ([0,2.5, -4.7]) cube ([2.0, 2.0, 45.5], center=true);  
  translate ([0,7.5, 5]) rotate([-18,0,0]) cube ([2.0, 2.0, 32], center=true);   
}
}
}


//// Use this module if you want the realistic  armchair nanotorid, which takes longer to render
i=0;
module torroid6_6(){
for(i=[0:30:330]){
rotate([0,0,i])
translate([18.1,-5.2,0])
rotate([0,90,90])
if (i==330 || i==30 || i==60) import("CNTR_6_6_champferd_notPunched.stl");
else 
import("CNTR_6_6_champferd_punched.stl");
}
}

//// This module creates the substrate upon which everything rests.  

module substrate(){
difference(){
   translate ([0,0,-8]) cube([160,160,16], center=true);
   squareSpokes();
   translate([0,0,-1.37]) rotate_extrude (convexity=10)  
   translate([18.1,0,12]) rotate([0,0,90]) square(3.0,center=true);      
   AllPads_no_notches();  
}
}

module modelTorid(){
difference(){    
    color("slateGrey",.8)
rotate_extrude (convexity=10){
translate([18.1,0,0]) rotate([0,0,90]) circle(d=2.494184, $fn=36);
}
modelSpokes();
}
}

module pads(){
union(){    
for(i=[0:30:330]){
rotate([0,0,i])
if (i==330 || i==30 || i==60) {}
else if (i==0) translate([18.1,0,0]) rotate([0,0,-22.5]) translate([53,0,-1.95]) 
 cube ([10, 10, 4], center=true);
else translate([18.1,0,0]) rotate([0,0,-30]) translate([53,0,-1.95]) rotate([0,0,12])  cube ([10, 10, 4], center=true);
}
}
}

module ssDNA(){
scale([.1,.1,.1]) import("ssDNA_0.stl");
    }


module notchedPads(){
difference(){
union(){    
for(i=[0:30:330]){
rotate([0,0,i])
if (i==330 || i==30 || i==60) {}
else if (i==0) translate([18.1,0,0]) rotate([0,0,10]) translate([53,0,-2]) 
 cube ([10, 10, 4], center=true);
else translate([18.1,0,0]) rotate([0,0,-30]) translate([53,0,-2]) 
 cube ([10, 10, 4], center=true);
}
}
squareSpokes();
}
 
rotate([0,0,12]) scale([1,1,1]) pads(); 
}


module AllPads_no_notches(){
    
for(i=[0:30:330]){
rotate([0,0,i])
if (i==330 || i==30 || i==60) {}
else if (i==0) translate([18.1,0,0]) rotate([0,0,10]) translate([53,0,-2]) 
 cube ([10, 10, 4], center=true);
else translate([18.1,0,0]) rotate([0,0,-30]) translate([53,0,-2]) 
 cube ([10, 10, 4], center=true);

}
 
rotate([0,0,12]) scale([1,1,1]) pads(); 
}



color("silver", .9) import ("Substrate_new_A.stl");//<--new
modelTorid();
color("slateGrey")modelSpokes();
color("gold")notchedPads();
color("DarkSeaGreen", .9)translate([0,0,-1])fields();
color ("gold") import ("ThoughtChip_logo.stl");

////  this imports a .svg version of the ThoughtChip logo
/*
translate ([15,-50,-.5]) scale ([.12,.12,.12]) color ("gold") scale ([5,5,5]) linear_extrude(height = 2, center = true)
import("ThoughtChip.svg");
*/

//// remove the comments below to render with ssDNA decoration on nanotorus
//// this part takes some time due to complexity
/*
color ("lightpink") for (i=[0:30:300]){
rotate([0,0,i+305])
translate ([0,19,2])  ssDNA();
}
*/

//// This module is used to create the substrate.  Once created, export it as an STL file, then import the STL file, which is much faster to render
/*
substrate();
*/

//// This module creates an armchair nanotorus, but is rather slow to render compared to the version below it.  Therefore, if you want to render with a realistic armchair toroid, use this to create the toroid, then export it with the name "torus_constr_manual.stl".  Then simply imort the newly constructed armchair torus in your main code.

/*
rotate([0,0,-1]) torroid6_6();
*/

//// This module creates a nanotorus with apertures by importing individual nanotube segments and fusing them together to form the nanotorus, which is much faster to render than the version above
/*
color ("gold") rotate([0,0,-1]) import ("torus_constr_manual.stl");
*/

////  This module creates the dendrites and axon using armchair chirality.  
////  This version takes much longer than the solid cylinder model version above or the manual version below.
////  for faster rendering, use the less realistic modelSpokes module near the top of this listing

/*
color ("grey") spokes();
*/

//squareSpokes();
//AllPads_no_notches();












