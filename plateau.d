module plateau;

import std.array, std.uni, std.conv, std.algorithm.iteration;

struct Plateau
{
    int x;
    int y;

    static Plateau from(string input)
    {
        int[] size = input.split!isWhite
            .map!(i => to!int(i))
            .array;
        return Plateau(size[0], size[1]);
    }
}

unittest
{
    auto plateau = Plateau.from("5 6");
    assert(plateau.x == 5);
    assert(plateau.y == 6);
}
