package sort_type


import "core:strings"
import "core:slice"
import "core:mem"
import "core:fmt"

@(private)
merge_sort_merge :: proc(l_arr: []string, r_arr: []string) -> []string {
  total_len := len(l_arr) + len(r_arr)
  res := make([]string, total_len)

  i: int
  l: int
  r: int

  for {
    if l == len(l_arr) {
      if r == len(r_arr) {
        break
      } else {
        res[i] = r_arr[r]
        r += 1
        i += 1
        continue
      }
    } else if r == len(r_arr) {
      res[i] = l_arr[l]
      l += 1
      i += 1
      continue
    } else {
      if strings.compare(l_arr[l], r_arr[r]) == 1 {
        res[i] = r_arr[r]
        r += 1
        i += 1
        continue
      } else {
        res[i] = l_arr[l]
        l += 1
        i += 1
        continue
      }
    }
  }

  return res
}


merge_sort :: proc(arr: []string) -> []string {
  if len(arr) == 1 {
    return slice.clone(arr)
  }
  if len(arr) == 2 {
    if strings.compare(arr[0], arr[1]) == 1 {
      res := slice.clone(arr)
      tmp := arr[1]
      res[1] = arr[0]
      res[0] = tmp
      return res
    } else {
      return slice.clone(arr)
    }
  }

  l_arr := slice.clone(arr[0:len(arr) / 2])
  defer delete(l_arr)
  r_arr := slice.clone(arr[len(arr) / 2:])
  defer delete(r_arr)

  l_arr_res := merge_sort(l_arr)
  defer delete(l_arr_res)
  r_arr_res := merge_sort(r_arr)
  defer delete(r_arr_res)

  fmt.printf("Merge to arrays: %v and %v\n", l_arr, r_arr)
  res := merge_sort_merge(l_arr_res, r_arr_res)

  return res
}

@(private)
merge_sort_t_merge :: proc(l_arr: []$T, r_arr: []T) -> []T {
  total_len := len(l_arr) + len(r_arr)
  res := make([]T, total_len)
  i: int
  l: int
  r: int

  for {
    if l == len(l_arr) {
      if r == len(r_arr) {
        break
      } else {
        res[i] = r_arr[r]
        r += 1
        i += 1
        continue
      }
    } else if r == len(r_arr) {
      res[i] = l_arr[l]
      l += 1
      i += 1
      continue
    } else {
      if l_arr[l] > r_arr[r]{
        res[i] = r_arr[r]
        r += 1
        i += 1
        continue
      } else {
        res[i] = l_arr[l]
        l += 1
        i += 1
        continue
      }
    }
  }
  return res
}


merge_sort_t :: proc(arr: []$T) -> []T {
  if len(arr) == 1 {
    return slice.clone(arr)
  }
  if len(arr) == 2 {
    if arr[0] > arr[1] {
      res := slice.clone(arr)
      tmp := arr[0]
      arr[0] = arr[1]
      arr[1] = tmp
      return res
    } else {
      return slice.clone(arr)
    }
  }

  l_arr := slice.clone(arr[0:len(arr) / 2])
  defer delete(l_arr)
  l_arr_res := merge_sort_t(l_arr)
  defer delete(l_arr_res)
  r_arr := slice.clone(arr[len(arr) / 2:])
  defer delete(r_arr)
  r_arr_res := merge_sort_t(r_arr)
  defer delete(r_arr_res)


  fmt.printf("Merge to arrays: %v and %v\n", l_arr, r_arr)
  res := merge_sort_t_merge(l_arr_res, r_arr_res)

  return res
}


main :: proc() {

  when ODIN_DEBUG {
    tracking: mem.Tracking_Allocator
    mem.tracking_allocator_init(&tracking, context.allocator)
    context.allocator = mem.tracking_allocator(&tracking)
  }


  arr := []string{ "The", "Project", "Gutenberg", "eBook",
    "of", "The", "Art", "of", "War", "This", "ebook",
    "is", "for", "the", "use", "of", "anyone", "anywhere",
    "in", "the", "United", "States", "and", "most",
    "other", "parts", "of", "the", "world", "at",
    "no", "cost", "and", "with", "almost", "no",
    "restrictions", "whatsoever", "You", "may", "copy", "it",
    "give", "it", "away", "or", "re" }


  // arr := []int {12, 8, 1, 0, 34, 17, 88, 11, 8, 9, 2, 3, 4, 7}


  // res := merge_sort_t(arr)
  res := merge_sort(arr)

  for a in res {
    fmt.println(a)
  }
  delete(res)
  when ODIN_DEBUG {
    for k, v in tracking.allocation_map {
      fmt.printf("Leak %v in %v\n", v.size, v.location)
    }

    mem.tracking_allocator_destroy(&tracking)
  }
}

