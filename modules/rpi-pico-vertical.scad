use <../base/gridfinity_cup_with_walls.scad>;
use <../lib/rounded_square.scad>;

module rpi_pico()
{
    board_width = 23;
    board_length = 53.5;
    board_height = 3.4;

    usb_width = 8.9;
    usb_length = 7.2;
    usb_height = 1.4;
    cube([ board_width, board_length, board_height ]);
    translate([ (board_width - usb_width) / 2, 0, board_height ]) cube([ usb_width, usb_length, usb_height ]);
}

cup_height = 4 * 7;

translate([ 0, 0, cup_height ]) gridfinity_cup_with_walls(1, 1, 3);
translate([0, 0, 7])linear_extrude(16.1) rounded_square(size = [ 41, 41 ], radius = 4, center = true);
