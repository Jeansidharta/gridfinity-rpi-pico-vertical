module rounded_hollow_square(outer_size, thickness, radius)
{
    new_outer_size = is_list(outer_size) ? [ outer_size[0] - radius * 2, outer_size[1] - radius * 2 ]
                                         : [ outer_size - radius * 2, outer_size - radius * 2 ];
    difference()
    {
        offset(radius) square(new_outer_size, center = true);
        offset(radius) square([ new_outer_size[0] - thickness, new_outer_size[1] - thickness ], center = true);
    }
}

linear_extrude(10) rounded_hollow_square(outer_size = [ 50, 100 ], thickness = 10, radius = 10);
