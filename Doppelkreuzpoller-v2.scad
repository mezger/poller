/*
//Grundplatte
translate([0,0,0.5])
cube(size=[15,5,1],center=true);
//Senkrecht
translate([4,0,0])
cylinder(h=9,r1=1.5,r2=1.5,$fn=100);
translate([-4,0,0])
cylinder(h=9,r1=1.5,r2=1.5,$fn=100);
//Waagrecht
translate([-7,0,5])
rotate(a=[0,90,0])
cylinder(h=14,r1=1.25,r2=1.25,$fn=100);
//AbschlussWaagrecht
translate([7,0,5])
    resize([1,0,0])
        sphere(d=3, $fn=100);
translate([-7,0,5])
    resize([1,0,0])
        sphere(d=3, $fn=100);
//AbschlussSenkrecht
translate([4,0,9])
    resize([0,0,1])
        sphere(d=3.5, $fn=100);
translate([-4,0,9])
    resize([0,0,1])
        sphere(d=3.5, $fn=100);
*/

module grundplatte(laenge, breite)
{
    translate([0,0,0.5])
        cube(size=[laenge,breite,1],center=true);
}

module senkrecht(laenge, breite, hoehe)
{
    radius=breite*0.3;
    xoffset=laenge/4;
    
    //rechte Stange
    translate([xoffset,0,0])
        cylinder(h=hoehe,r1=radius,r2=radius,$fn=100);

    //linke Stange
    translate([-xoffset,0,0])
        cylinder(h=hoehe,r1=radius,r2=radius,$fn=100);
    
    //Abschluß rechte Stange
    translate([xoffset,0,hoehe])
        resize([0,0,(hoehe/9)]) //früher:10
            sphere(d=(2.4*radius), $fn=100); //früher: 2.3
   
    //Abschluß linke Stange
    translate([-xoffset,0,hoehe])
        resize([0,0,(hoehe/9)]) //früher:10
            sphere(d=(2.4*radius), $fn=100); //früher: 2.3
}

module waagrecht(laenge, breite, hoehe)
{
    radius=laenge/10;  //früher: 12
    yoffset=(hoehe*1.2)/2;
    
    //Querstange
    translate([-(0.45*laenge),0,yoffset])
        rotate(a=[0,90,0])
            cylinder(h=(0.9*laenge),r1=radius,r2=radius,$fn=100);

    //Abschluß rechts
    translate([(0.45*laenge),0,yoffset])
        resize([(laenge/13),0,0])  //früher: 15
            sphere(d=(2.4*radius), $fn=100); //früher: 2.3

    //Abschluß links
    translate([-(0.45*laenge),0,yoffset])
        resize([(laenge/13),0,0])
            sphere(d=(2.4*radius), $fn=100); //früher: 2.3
}

module doppelkreuzpoller(laenge)
{
    breite=laenge/2.5; //früher: /3
    hoehe=laenge*0.6;

    grundplatte(laenge, breite);
    senkrecht(laenge, breite, hoehe);
    waagrecht(laenge, breite, hoehe);
}

module doppelpoller(laenge)
{
    breite=laenge/3;
    hoehe=laenge/2.2;

    grundplatte(laenge, breite);
    senkrecht(laenge, breite, hoehe);
}

size=15;
difference()
{
    union()
    {
        translate([0,-2,0])
            rotate(a=[90,0,0])
                doppelkreuzpoller(size);
        translate([0,2,0])
            rotate(a=[-90,0,0])
                doppelkreuzpoller(size);
    }
    translate([0,0,-size/2])
        cube([2*size,2*size,size], center=true);
}
//translate([0,-20,0]) doppelpoller(15);