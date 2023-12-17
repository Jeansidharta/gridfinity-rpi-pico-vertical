use <../libs/gridfinity-openscad/gridfinity_cup_with_walls.scad>;
use <../libs/gridfinity-openscad/rounded_square.scad>;

module rpi_pico()
{
    board_width = 23;
    board_length = 53.5;
    board_height = 3.4;

    usb_width = 8.9;
    usb_length = 53.5;
    usb_height = 1.4;
    rotate([ 90, 0, 0 ]) translate([ -board_width / 2, 0, 0 ])
    {
        cube([ board_width, board_length, board_height ]);
        translate([ (board_width - usb_width) / 2, 0, board_height ]) cube([ usb_width, usb_length, usb_height ]);
    }
}

cup_layers = 6;
cup_height = (cup_layers + 1) * 7 - 2.25;

difference()
{
    union()
    {
        translate([ 0, 0, cup_height ]) gridfinity_cup_with_walls(1, 1, cup_layers, use_stacking_lip = false);
        translate([ 0, 0, 7 ]) linear_extrude(cup_layers * 7 - 2.25)
            rounded_square(size = [ 41, 41 ], radius = 4, center = true);
    }
    minkowski()
    {
        union()
        {
            translate([ 7, 18, 8 ]) rpi_pico();
            translate([ 7, 10, 8 ]) rpi_pico();
            translate([ 7, 2, 8 ]) rpi_pico();
            translate([ 7, -6, 8 ]) rpi_pico();
            translate([ 7, -14, 8 ]) rpi_pico();
            translate([ -14, -7, 8 ]) rotate([ 0, 0, -90 ]) rpi_pico();
            translate([ -7, -7, 8 ]) rotate([ 0, 0, -90 ]) rpi_pico();
        }
        sphere(r = 0.75);
    }
    translate([ -18, 10, cup_height - 1 ])
    {
        linear_extrude(2) scale(0.05) import(file = "../assets/raspberry-pi.svg");
        translate([ 0, -2.5, 0 ]) linear_extrude(2) text("PICO", 3);
    }
}
