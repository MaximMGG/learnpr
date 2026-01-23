package sort_type


import "core:fmt"
import "core:mem"
import "core:time"
import "core:math/rand"
import "core:reflect"
import "core:strings"

partition :: proc(arr: ^[]$T, lo: int, hi: int) -> int {
  pivot := arr[hi]
  idx := lo - 1

  if reflect.is_string(type_info_of(type_of(arr[0]))) {
    for i in lo..<hi {
      if strings.compare(arr[i], pivot) <= 0 {
        idx += 1
        arr[i], arr[idx] = arr[idx], arr[i]
      }
    }
  } else {
    for i in lo..<hi {
      if arr[i] <= pivot {
        idx += 1
        arr[i], arr[idx] = arr[idx], arr[i]
      }
    }
  }
  idx += 1
  arr[hi], arr[idx] = arr[idx], arr[hi]

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

COUNT :: 1_000_000

main :: proc() {
  when ODIN_DEBUG {
    tracking: mem.Tracking_Allocator
    mem.tracking_allocator_init(&tracking, context.allocator)
    context.allocator = mem.tracking_allocator(&tracking)
  }

  arr := []int{1,2 ,1,5, 6,234, 123, 556, 22, 6666, 2, 1, 0, 3}
  // arr := []string{ "The", "Project", "Gutenberg", "eBook",
  //   "of", "The", "Art", "of", "War", "This", "ebook",
  //   "is", "for", "the", "use", "of", "anyone", "anywhere",
  //   "in", "the", "United", "States", "and", "most",
  //   "other", "parts", "of", "the", "world", "at",
  //   "no", "cost", "and", "with", "almost", "no",
  //   "restrictions", "whatsoever", "You", "may", "copy", "it",
  //   "give", "it", "away", "or", "re" }


  // quick_sort(&arr)
  merge_sort(arr)
  for v in arr {
    fmt.println(v)
  }

  // arr := make([]int, COUNT)
  // arr2 := make([]int, COUNT)
  // defer {
  //   delete(arr)
  //   delete(arr2)
  // }
  //
  // for i in 0..<COUNT {
  //   num := rand.int32_range(0, (1 << 31) - 1)
  //   arr[i] = int(num)
  //   arr2[i] = int(num)
  // }
  //
  //
  // whatch: time.Stopwatch
  //
  // time.stopwatch_start(&whatch)
  // res := merge_sort_t(arr)
  // time.stopwatch_stop(&whatch)
  // time_res := time.stopwatch_duration(whatch)
  // mil := time.duration_milliseconds(time_res)
  // fmt.println("Merge sort:", mil)
  // defer delete(res)
  // time.stopwatch_reset(&whatch)
  //
  //
  // time.stopwatch_start(&whatch)
  // quick_sort(&arr)
  // time.stopwatch_stop(&whatch)
  // time_res = time.stopwatch_duration(whatch)
  // mil = time.duration_milliseconds(time_res)
  // fmt.println("Quick sort:", mil)

  when ODIN_DEBUG {
    for k, v in tracking.allocation_map {
      fmt.printf("Leak %v in %v\n", v.size, v.location)
    }

    mem.tracking_allocator_destroy(&tracking)
  }
}
