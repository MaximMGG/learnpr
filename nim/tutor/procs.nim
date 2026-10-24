




proc yes(question: string): bool =
  echo question, " (y/n)"
  while true:
    case readLine(stdin):
    of "y", "Y", "yes", "Yes": return true
    of "n", "N", "no", "No": return false
    else: echo "Enter only yes or no"


if yes("Do you like dogs?"):
  echo "Yes he likes dogs"
else:
  echo "No he doesn't like dogs"



