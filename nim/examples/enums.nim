

type
  CompassDirections = enum
    cdNorth, cdEast, cdSouth, cdWest

  Colors {.pure.} = enum
    Red = "FF0000", Green = (1, "00FF00"), Blue = "0000FF"

  OtherColor {.pure.} = enum
    Red = 0xFF0000, Orange = 0xFFA500, Yellow = 0xFFFF00

  Signals = enum
    sigQuit = 3, sigAbort = 6, sigKill = 9


echo Colors.Red
echo OtherColor.Red
echo OtherColor.Orange, " ", Orange
echo Signals.sigQuit
echo ord(Signals.sigQuit)

for direction in ord(low(CompassDirections))..ord(high(CompassDirections)):
  echo CompassDirections(direction), " ord: ", direction
