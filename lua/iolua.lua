io.write("hello\n")



local foo = function(x)
    if x > 0 and x <= 8 then
        for i = 1, 9 do
            if x == i then
                io.write("X")
            else
                io.write("-")
            end
        end
        io.write("\n")
    end
end

for i = 1, 9 do
    foo(math.random(1, 8))
end
