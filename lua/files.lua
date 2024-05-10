-- io.output("hello.txt")
-- io.write("Hello world!")
-- io.close()


-- io.input("hello.txt")
--
-- local f = io.read()
--
-- io.close()
--
-- print(f)


local file = io.open("hello.txt", "a")

if file ~= nil then

    file:write("Hello my name is Bob\n")

    file:write([[<html>
    <head>
    <title>Hello</title>
    </head>]])

    file:close()
end


