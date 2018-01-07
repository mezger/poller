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
    translate([-(0.5*laenge),0,yoffset])
        rotate(a=[0,90,0])
            cylinder(h=(laenge),r1=radius,r2=radius,$fn=100);

    //Abschluß rechts
    translate([(0.5*laenge),0,yoffset])
        resize([(laenge/13),0,0])  //früher: 15
            sphere(d=(2.4*radius), $fn=100); //früher: 2.3

    //Abschluß links
    translate([-(0.5*laenge),0,yoffset])
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
    breite=laenge/2.5;
    hoehe=laenge/2.5;

    grundplatte(laenge, breite);
    senkrecht(laenge, breite, hoehe);
}

module splitdoppelkreuzpoller(size)
{
    difference()
    {
        union()
        {
            translate([0,-2,0.5]) //0.5mm abheben, 2mm Abstand zur X-Achse
                rotate(a=[90,0,0]) //nach links kippen
                    doppelkreuzpoller(size);
            translate([0,2,0.5])
                rotate(a=[-90,0,0])
                    doppelkreuzpoller(size);
        }
        translate([0,0,-size/2])
            cube([2*size,2*size,size], center=true);
    }
}


size=18;

//2 halbe Doppelkreuzpoller
splitdoppelkreuzpoller(size);

//Doppelkreuzpoller
//doppelkreuzpoller(size);

//Doppelpoller
//doppelpoller(size);