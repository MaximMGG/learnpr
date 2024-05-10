local p = os.time({
    year = 2000,
    month = 10,
    day = 3,
    hour = 13,
    min = 20,
    sec = 59
})

-- print(os.time() - p)
-- print(os.difftime(os.time(), p))
-- same
print(os.clock())

os.execute("ls")
os.execute("echo $HOME")

print(os.getenv("HOME"))
os.remove("hello.txt")
