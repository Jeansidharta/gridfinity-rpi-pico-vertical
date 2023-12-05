include <gridfinity_cup_base_vars.scad>
use <../lib/rounded_hollow_square.scad>;
use <../lib/rounded_square.scad>;
use <gridfinity_cup_base.scad>;

$fn = 20;

module gridfinity_cup_with_walls(rows = 1, columns = 1, layers = 3, magnets = true, stacking_lip = true)
{
    width = rows * cup_base_top_size;
    length = columns * cup_base_top_size;
    walls_height = (layers - 1) * 7;
    walls_thickness = 2;
    walls_radius = 4;

    floor_height = 2.25;
    floor_base_angle = 3.75;
    translate([ 0, 0, -7 ])
    {
        translate([ 0, 0, -walls_height ])
        {
            translate([ 0, 0, -floor_height ])
            {
                // Bases
                translate([ -(width - cup_base_top_size) / 2, -(length - 41.75) / 2 ])
                {
                    for (row = [0:rows - 1])
                    {
                        for (column = [0:columns - 1])
                        {
                            translate([ row * 42, column * 42, 0 ]) gridfinity_cup_base(magnets = magnets);
                        }
                    }
                }

                // floor
                hull()
                {
                    linear_extrude(0.001)
                        rounded_square(size = [ width, length ], radius = floor_base_angle, center = true);
                    translate([ 0, 0, floor_height ]) linear_extrude(0.001)
                        rounded_square(size = [ width, length ], radius = walls_radius, center = true);
                }
            }

            // walls
            linear_extrude(walls_height) rounded_hollow_square(outer_size = [ width, length ],
                                                               thickness = walls_thickness, radius = walls_radius);
        }

        // top
        stacking_lip_bottom_width = width - (cup_base_top_size - cup_base_bottom_size);
        stacking_lip_middle_width = width - (cup_base_top_size - cup_base_middle_size);
        stacking_lip_bottom_length = length - (cup_base_top_size - cup_base_bottom_size);
        stacking_lip_middle_length = length - (cup_base_top_size - cup_base_middle_size);
        stacking_lip_top_width = width;
        stacking_lip_top_length = length;

        // This is to make sure the overhang is not over 45 degrees
        stacking_lip_overhang_height = (cup_base_top_size - cup_base_bottom_size - walls_thickness) / 2;

        total_lip_height =
            stacking_lip_overhang_height + bottom_slope_height + middle_height + top_slope_height - 0.001 * 4;

        difference()
        {
            linear_extrude(7) rounded_square(size = [ width, length ], radius = walls_radius, center = true);
            translate([ 0, 0, 7 - total_lip_height - 0.001 ])
            {
                translate([ 0, 0, stacking_lip_overhang_height - 0.001 ]) hull()
                {
                    translate([ 0, 0, bottom_slope_height - 0.001 ])
                    {
                        linear_extrude(middle_height)
                            rounded_square(size = [ stacking_lip_middle_width, stacking_lip_middle_length ],
                                           radius = middle_radius, center = true);

                        translate([ 0, 0, middle_height - 0.001 ]) hull()
                        {
                            translate([ 0, 0, top_slope_height ]) linear_extrude(0.001)
                                rounded_square(size = [ stacking_lip_top_width, stacking_lip_top_length ],
                                               radius = walls_radius, center = true);
                            linear_extrude(0.001)
                                rounded_square(size = [ stacking_lip_middle_width, stacking_lip_middle_length ],
                                               radius = middle_radius, center = true);
                        }
                    }
                    translate([ 0, 0, bottom_slope_height ]) linear_extrude(0.001)
                        rounded_square(size = [ stacking_lip_middle_width, stacking_lip_middle_length ],
                                       radius = middle_radius, center = true);
                    linear_extrude(0.001)
                        rounded_square(size = [ stacking_lip_bottom_width, stacking_lip_bottom_length ],
                                       radius = bottom_radius, center = true);
                }
                hull()
                {
                    translate([ 0, 0, stacking_lip_overhang_height ]) linear_extrude(0.001)
                        rounded_square(size = [ stacking_lip_bottom_width, stacking_lip_bottom_length ],
                                       radius = bottom_radius, center = true);
                    linear_extrude(0.001) rounded_square(size = [ width - walls_thickness, length - walls_thickness ],
                                                         radius = walls_radius, center = true);
                }
                translate([ 0, 0, -10 + 0.001 ]) linear_extrude(10)
                    rounded_square(size = [ width - walls_thickness - 0.001, length - walls_thickness - 0.001 ],
                                   radius = walls_radius, center = true);
            }
        }
    }

    module internal_floor()
    {
        hull()
        {
            linear_extrude(0.001) rounded_square(size = [ width, length ], radius = floor_base_angle, center = true);
            translate([ 0, 0, floor_height ]) linear_extrude(0.001)
                rounded_square(size = [ width, length ], radius = walls_radius, center = true);
        }
    }

    module walls()
    {

        linear_extrude(walls_height)
            rounded_hollow_square(outer_size = [ width, length ], thickness = walls_thickness, radius = walls_radius);
    }

    module stacking_lip()
    {
        // top
        stacking_lip_bottom_width = width - (cup_base_top_size - cup_base_bottom_size);
        stacking_lip_middle_width = width - (cup_base_top_size - cup_base_middle_size);
        stacking_lip_bottom_length = length - (cup_base_top_size - cup_base_bottom_size);
        stacking_lip_middle_length = length - (cup_base_top_size - cup_base_middle_size);
        stacking_lip_top_width = width;
        stacking_lip_top_length = length;

        // This is to make sure the overhang is not over 45 degrees
        stacking_lip_overhang_height = (cup_base_top_size - cup_base_bottom_size - walls_thickness) / 2;

        total_lip_height =
            stacking_lip_overhang_height + bottom_slope_height + middle_height + top_slope_height - 0.001 * 4;

        difference()
        {
            linear_extrude(7) rounded_square(size = [ width, length ], radius = walls_radius, center = true);
            translate([ 0, 0, 7 - total_lip_height - 0.001 ])
            {
                translate([ 0, 0, stacking_lip_overhang_height - 0.001 ]) hull()
                {
                    translate([ 0, 0, bottom_slope_height - 0.001 ])
                    {
                        linear_extrude(middle_height)
                            rounded_square(size = [ stacking_lip_middle_width, stacking_lip_middle_length ],
                                           radius = middle_radius, center = true);

                        translate([ 0, 0, middle_height - 0.001 ]) hull()
                        {
                            translate([ 0, 0, top_slope_height ]) linear_extrude(0.001)
                                rounded_square(size = [ stacking_lip_top_width, stacking_lip_top_length ],
                                               radius = walls_radius, center = true);
                            linear_extrude(0.001)
                                rounded_square(size = [ stacking_lip_middle_width, stacking_lip_middle_length ],
                                               radius = middle_radius, center = true);
                        }
                    }
                    translate([ 0, 0, bottom_slope_height ]) linear_extrude(0.001)
                        rounded_square(size = [ stacking_lip_middle_width, stacking_lip_middle_length ],
                                       radius = middle_radius, center = true);
                    linear_extrude(0.001)
                        rounded_square(size = [ stacking_lip_bottom_width, stacking_lip_bottom_length ],
                                       radius = bottom_radius, center = true);
                }
                hull()
                {
                    translate([ 0, 0, stacking_lip_overhang_height ]) linear_extrude(0.001)
                        rounded_square(size = [ stacking_lip_bottom_width, stacking_lip_bottom_length ],
                                       radius = bottom_radius, center = true);
                    linear_extrude(0.001) rounded_square(size = [ width - walls_thickness, length - walls_thickness ],
                                                         radius = walls_radius, center = true);
                }
                translate([ 0, 0, -10 + 0.001 ]) linear_extrude(10)
                    rounded_square(size = [ width - walls_thickness - 0.001, length - walls_thickness - 0.001 ],
                                   radius = walls_radius, center = true);
            }
        }
    }

}

gridfinity_cup_with_walls(1, 1, 1);
