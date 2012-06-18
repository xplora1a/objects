//cube([42.5,42.5,42.5]);
intersection()
{
   translate([-6.5,-6.5,21.25]) linear_extrude(file="qrcode_mc_escher.dxf",height=42.5, center=true);
   rotate([90,0,0]) translate([-7.5,-7.5,-21.25]) linear_extrude(file="qrcode_bach.dxf",height=42.5, center=true);
   rotate([0,90,0]) translate([-50,-7.5,21.25]) linear_extrude(file="qrcode_goedel.dxf",height=42.5, center=true);
}