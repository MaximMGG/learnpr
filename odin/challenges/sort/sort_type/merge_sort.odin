package sort_type


import "core:strings"
import "core:sort"


merge_sort :: proc{merge_sort_num, merge_sort_string}

merge_sort_merge_string :: proc(arr: []string, l_arr: []string, r_arr: []string) {
  i: int
  l: int
  r: int

  for {
    if l == len(l_arr) {
      if r == len(r_arr) {
        return
      } else {
        arr[i] = r_arr[r]
        r += 1
        i += 1
      }
    } else if r == len(r_arr) {
      arr[i] = l_arr[l]
      l += 1
      i += 1
    } else {
      if strings.compare(arr[l], arr[r]) > 1{
        arr[i] = r_arr[r]
        r += 1
        i += 1
      } else {
        arr[i] = l_arr[l]
        l += 1
        r += 1
      }
    }
  }
}

merge_sort_string :: proc(arr: []string) {
  if len(arr) == 1 {
    return
  }
  if len(arr) == 2 {
    if strings.compare(arr[0], arr[1]) > 1 {
      arr[0], arr[1] = arr[1], arr[0]
    }
  }

  merge_sort_string(arr[0:len(arr) / 2])
  merge_sort_string(arr[len(arr) / 2:])
  merge_sort_merge_string(arr, arr[0:len(arr) / 2], arr[len(arr) / 2:])
}

@(private)
merge_sort_merge_num :: proc(arr: []$T, l_arr: []T, r_arr: []T) {
  i: int
  l: int
  r: int

  for {
    if l == len(l_arr) {
      if r == len(r_arr) {
        return
      } else {
        arr[i] = r_arr[r]
        r += 1
        i += 1
      }
    } else if r == len(r_arr) {
      arr[i] = l_arr[l]
      l += 1
      i += 1
    } else {
      if l_arr[l] > r_arr[r] {
        arr[i] = r_arr[r]
        r += 1
        i += 1
      } else {
        arr[i] = l_arr[l]
        l += 1
        r += 1
      }
    }
  }
}

merge_sort_num :: proc(arr: []$T) {
  if len(arr) == 1 {
    return
  }
  if len(arr) == 2 {
    if arr[0] > arr[1] {
      arr[0], arr[1] = arr[1], arr[0]
    }
  }

  merge_sort(arr[0:len(arr) / 2])
  merge_sort(arr[len(arr) / 2:])
  merge_sort_merge_num(arr, arr[0:len(arr) / 2], arr[len(arr) / 2:])
}


