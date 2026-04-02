import std/json

proc main() =
  var
    dbname: string
    user_name: string
    password: string

  echo "Enter dbname: "
  dbname = stdin.readLine()
  echo "Enter user_name: "
  user_name = stdin.readLine()
  echo "Enter password: "
  password = stdin.readLine()

  const json_name = "test.json"

  let j = %*
    {
      "dbname": dbname,
      "user_name": user_name,
      "password": password
    }

  var f: File
  if not open(f, json_name, fmWrite):
    echo "Cant open "
    quit()

  f.write(j)
  

main()
