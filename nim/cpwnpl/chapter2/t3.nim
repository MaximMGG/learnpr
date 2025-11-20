

type
    MyGenericConteiner*[T] = object
        storage: array[2, T]

proc add*[T](c: var MyGenericConteiner[T], x, y: T) = 
    c.storage[0] = x
    c.storage[1] = y

proc sortBy*[T](c: var MyGenericConteiner[T], smaller: proc(a, b: T): bool) =
    if smaller(c.storage[1], c.storage[0]):
        swap(c.storage[0], c.storage[1])

proc `$`*[T](c: MyGenericConteiner[T]): string = 
    `$`(c.storage[0]) & ", " & `$`(c.storage[1])
