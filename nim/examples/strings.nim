import strutils

echo "words words words"
echo """
<htlm>
  <head>
  </head>\n\n

  <body>
  </body>
</htlm>
"""
proc re(s: string): string = s


echo r".""."
echo re"\b[a-z]++\b"

echo "agc"[0]

echo "abcdefg"[0..4]
echo "abcdefg"[0..^2]

var a = "Hello welcome, friend"

echo a.split({' ', ','})

echo a.contains("welcome")
