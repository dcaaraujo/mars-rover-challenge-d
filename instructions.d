module instructions;

enum Instruction
{
    TURN_LEFT,
    TURN_RIGHT,
    MOVE_FORWARD
}

Instruction[] parseInstructions(string input)
{
    Instruction[] instructions;
    foreach (c; input)
    {
        switch (c)
        {
        case 'L':
            instructions ~= Instruction.TURN_LEFT;
            break;
        case 'R':
            instructions ~= Instruction.TURN_RIGHT;
            break;
        case 'M':
            instructions ~= Instruction.MOVE_FORWARD;
            break;
        default:
            continue;
        }
    }
    return instructions;
}

unittest
{
    auto instructions = parseInstructions("MLRRM");
    auto expectedInstructions = [
        Instruction.MOVE_FORWARD,
        Instruction.TURN_LEFT,
        Instruction.TURN_RIGHT,
        Instruction.TURN_RIGHT,
        Instruction.MOVE_FORWARD
    ];
    assert(instructions == expectedInstructions);
}
