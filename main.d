import std.stdio, std.string, plateau, rover, instructions;

void main()
{
    auto input = readln.chomp;
    auto plateau = Plateau.from(input);
    while (true)
    {
        input = readln.chomp;
        if (input.toLower() == "q")
        {
            break;
        }
        auto rover = Rover.at(input);
        input = readln.chomp;
        auto instructions = parseInstructions(input);
        try
        {
            rover.process(instructions, plateau);
            writeln(rover.toString());
        }
        catch (StringException e)
        {
            writeln(e.msg);
        }
    }
}
