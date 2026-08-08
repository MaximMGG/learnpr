


main = putStrLn (makeHtml "Title" "Hello world!")

wrapHtml content = "<html><body>" <> content <> "</body></html"

makeHtml :: String -> String -> String
makeHtml title content = "<html><head><title>" <> title <> "</title></head><dody>" <> content <> "</body></html>"

el :: String -> String -> String

el tag content =
  "<" <> tag <> ">" <> content <> "</" <> tag <> ">"


html_ :: String -> String
html_ = el "html"


body_ :: String -> String
body_ = el "body"

three = (\num1 -> \num2 -> num1 + num2) 1 2


newtype Htlm = Html String



