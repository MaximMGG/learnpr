package sort_type


import "core:fmt"
import "core:mem"

partition :: proc(arr: ^[]$T, lo: int, hi: int) -> int {
  pivot := arr[hi]
  idx := lo - 1

  for i in lo..<hi {
    if arr[i] <= pivot {
      idx += 1
      tmp := arr[idx]
      arr[idx] = arr[i]
      arr[i] = tmp
    }
  }
  idx += 1

  return idx
}

sort :: proc(arr: ^[]$T, lo: int, hi: int) {
  if (lo >= hi) {
    return
  }
  pivotIndex := partition(arr, lo, hi)
  sort(arr, lo, pivotIndex - 1)
  sort(arr, pivotIndex + 1, hi)
}

quick_sort :: proc(arr: ^[]$T) {
  sort(arr, 0, len(arr) - 1)
}

main :: proc() {
  when ODIN_DEBUG {
    tracking: mem.Tracking_Allocator
    mem.tracking_allocator_init(&tracking, context.allocator)
    context.allocator = mem.tracking_allocator(&tracking)
  }

  // arr := []string{ "The", "Project", "Gutenberg", "eBook",
  //   "of", "The", "Art", "of", "War", "This", "ebook",
  //   "is", "for", "the", "use", "of", "anyone", "anywhere",
  //   "in", "the", "United", "States", "and", "most",
  //   "other", "parts", "of", "the", "world", "at",
  //   "no", "cost", "and", "with", "almost", "no",
  //   "restrictions", "whatsoever", "You", "may", "copy", "it",
  //   "give", "it", "away", "or", "re" }


  // arr := []int {12, 8, 1, 0, 34, 17, 88, 11, 8, 9, 2, 3, 4, 7}
  arr := []int{9, 8, 7, 6, 5, 4, 3, 2, 1, 0}


  // res := merge_sort_t(arr)
  quick_sort(&arr)

  for a in arr {
    fmt.println(a)
  }
  // delete(res)
  when ODIN_DEBUG {
    for k, v in tracking.allocation_map {
      fmt.printf("Leak %v in %v\n", v.size, v.location)
    }

    mem.tracking_allocator_destroy(&tracking)
  }
}
