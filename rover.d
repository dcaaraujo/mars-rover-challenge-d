module rover;

import std.string, std.format, std.uni, std.conv, std.exception, instructions, plateau;

enum RoverDirection : char
{
    NORTH = 'N',
    SOUTH = 'S',
    EAST = 'E',
    WEST = 'W'
}

struct Rover
{
    int posX;
    int posY;
    RoverDirection direction;

    static Rover at(string input)
    {
        string[] args = input.split!isWhite;
        auto x = to!int(args[0]);
        auto y = to!int(args[1]);
        auto dir = to!char(args[2]);
        return Rover(x, y, cast(RoverDirection) dir);
    }

    void process(Instruction[] instructions, Plateau plateau)
    {
        foreach (i; instructions)
        {
            final switch (i)
            {
            case Instruction.TURN_LEFT:
                turnLeft();
                break;
            case Instruction.TURN_RIGHT:
                turnRight();
                break;
            case Instruction.MOVE_FORWARD:
                move(plateau);
                break;
            }
        }
    }

    string toString()
    {
        return format("%s %s %c", posX, posY, direction);
    }

    private void turnLeft()
    {
        final switch (direction)
        {
        case RoverDirection.NORTH:
            direction = RoverDirection.WEST;
            break;
        case RoverDirection.SOUTH:
            direction = RoverDirection.EAST;
            break;
        case RoverDirection.EAST:
            direction = RoverDirection.NORTH;
            break;
        case RoverDirection.WEST:
            direction = RoverDirection.SOUTH;
            break;
        }
    }

    private void turnRight()
    {
        final switch (direction)
        {
        case RoverDirection.NORTH:
            direction = RoverDirection.EAST;
            break;
        case RoverDirection.SOUTH:
            direction = RoverDirection.WEST;
            break;
        case RoverDirection.EAST:
            direction = RoverDirection.SOUTH;
            break;
        case RoverDirection.WEST:
            direction = RoverDirection.NORTH;
            break;
        }
    }

    private void move(Plateau plateau)
    {
        final switch (direction)
        {
        case RoverDirection.NORTH:
            posY += 1;
            break;
        case RoverDirection.SOUTH:
            posY -= 1;
            break;
        case RoverDirection.EAST:
            posX += 1;
            break;
        case RoverDirection.WEST:
            posX -= 1;
            break;
        }
        if (posX < 0 || posX > plateau.x || posY < 0 || posY > plateau.y)
        {
            throw new StringException("The rover fell off the plateau!");
        }
    }
}

unittest
{
    auto rover = Rover.at("1 2 N");
    assert(rover.posX == 1);
    assert(rover.posY == 2);
    assert(rover.direction == RoverDirection.NORTH);
}

unittest
{
    auto plateau = Plateau(5, 5);
    auto rover = Rover.at("1 2 N");
    rover.process(parseInstructions("LMLMLMLMM"), plateau);
    assert(rover.posX == 1);
    assert(rover.posY == 3);
    assert(rover.direction == RoverDirection.NORTH);
}

unittest
{
    auto plateau = Plateau(5, 5);
    auto rover = Rover.at("3 3 E");
    rover.process(parseInstructions("MMRMMRMRRM"), plateau);
    assert(rover.posX == 5);
    assert(rover.posY == 1);
    assert(rover.direction == RoverDirection.EAST);
}

unittest
{
    auto rover = Rover.at("1 2 N");
    assert(rover.toString() == "1 2 N");
}

unittest
{
    auto plateau = Plateau(5, 2);
    auto rover = Rover.at("0 0 N");
    assertThrown!StringException(rover.process(parseInstructions("MMMM"), plateau));
}
