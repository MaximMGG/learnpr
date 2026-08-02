import module_a, module_b

write(stdout, module_a.x)
write(stdout, module_b.x)



var a: seq[int] = @[3, 3, 3]
var b: seq[int] = @[6, 6, 6]


echo module_a.`*`(a, b)



