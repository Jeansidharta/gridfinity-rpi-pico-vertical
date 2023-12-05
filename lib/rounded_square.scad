module rounded_square(size, radius, center = false)
{
    new_size = is_list(size) ? [ size[0] - radius * 2, size[1] - radius * 2 ] : size - radius * 2;
    offset(radius) square(new_size, center);
}

rounded_square(size = 10, radius = 2, center = true);
