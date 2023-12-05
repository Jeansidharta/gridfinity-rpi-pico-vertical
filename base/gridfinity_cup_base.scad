include <gridfinity_cup_base_vars.scad>
use <../lib/rounded_square.scad>;

module gridfinity_cup_base(magnets = true)
{
    module base_no_magnets()
    {
        translate([ 0, 0, -top_slope_height ])
        {
            hull()
            {
                translate([ 0, 0, top_slope_height ]) linear_extrude(0.001)
                    rounded_square(cup_base_top_size, radius = top_radius, center = true);
                linear_extrude(0.001) rounded_square(cup_base_middle_size, radius = middle_radius, center = true);
            }
            translate([ 0, 0, -middle_height + 0.001 ])
            {

                linear_extrude(middle_height)
                    rounded_square(cup_base_middle_size, radius = middle_radius, center = true);
                translate([ 0, 0, -bottom_slope_height + 0.001 ])
                {
                    hull()
                    {
                        linear_extrude(0.001)
                            rounded_square(cup_base_bottom_size, radius = bottom_radius, center = true);
                        translate([ 0, 0, bottom_slope_height ]) linear_extrude(0.001)
                            rounded_square(cup_base_middle_size, radius = middle_radius, center = true);
                    }
                }
            }
        }
    }

    module magnet()
    {
        height = 2;
        outter_radius = 3.25;
        inner_radius = 1.5;
        translate([ 0, 0, height / 2 ])
        {
            cylinder(h = height, r = outter_radius, center = true);
            translate([ 0, 0, height - 0.001 ]) cylinder(h = height, r = inner_radius, center = true);
        }
    }

    if (magnets)
    {
        magnet_xy_offset = (cup_base_bottom_size - 7.75) / 2;
        magnet_z_offset = -middle_height - top_slope_height - bottom_slope_height;
        difference()
        {
            base_no_magnets();
            translate([ magnet_xy_offset, magnet_xy_offset, magnet_z_offset ]) magnet();
            translate([ -magnet_xy_offset, magnet_xy_offset, magnet_z_offset ]) magnet();
            translate([ -magnet_xy_offset, -magnet_xy_offset, magnet_z_offset ]) magnet();
            translate([ magnet_xy_offset, -magnet_xy_offset, magnet_z_offset ]) magnet();
        }
    }
    else
    {
        base_no_magnets();
    }
}

gridfinity_cup_base(magnets = true);
