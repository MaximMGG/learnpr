import threadpool

proc sayHi(num: int) {.thread.} =
  echo "Hi from " & $num

var threads: array[10, Thread[int]]

for i in threads.low..threads.high:
  createThread(threads[i], sayHi, i)

joinThreads(threads)

for i in 0..9:
  spawn(sayHi(i))

sync()
