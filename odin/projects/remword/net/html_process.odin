package net_impl

import _module "../module"
import "core:os"
import "core:log"
import "core:fmt"
import "core:strings"
import "core:slice"


INDEX_MODULE_NAME :: "<li><a class=\"module-link\" href=\"%s\">%s</a></li>\n"

MODULE_WORD_TRANSLATION :: ` 
<tr>
<td>%s</td>
<td>%s</td>
<td>
<form class="inline-form" action="/delete_word" method="post">
<input type="hidden" name="word" value="%s">
<input type="submit" class="delete-btn" value="✖">
</form>
</td>
</tr>
`

Html_Fmt :: struct {
  index_html: string,
  module_html: string,
  combine_module_html: string,
  delete_module_html: string,
  create_module_html: string,
}

html_fmt: Html_Fmt

html_fmt_prepare :: proc() {
  hf: Html_Fmt
  index_file, index_ok := os.read_entire_file("./html/index.html")
  if !index_ok {
    log.error("open index.html error")
    return
  } else {
    hf.index_html = transmute(string)index_file 
  }
  module_file, module_ok := os.read_entire_file("./html/module.html")
  if !module_ok {
    log.error("open module.html error")
    delete(hf.index_html)
    return
  } else {
    hf.module_html = transmute(string)module_file
  }
  combine_module_file, combine_module_of := os.read_entire_file("./html/combine_modules.html")
  if !index_ok {
    log.error("open combine-modules.html error")
    delete(hf.index_html)
    delete(hf.module_html)
    return
  } else {
    hf.combine_module_html = transmute(string)combine_module_file
  }
  create_module_file, create_module_ok := os.read_entire_file("./html/create-module.html")
  if !create_module_ok {
    log.error("open create-module.html error")
    delete(hf.index_html)
    delete(hf.module_html)
    delete(hf.combine_module_html)
    return
  }
  delete_module_file, delete_module_ok := os.read_entire_file("./html/delete-module.html")
  if !delete_module_ok {
    log.error("open delete-module.html error")
    delete(hf.index_html)
    delete(hf.module_html)
    delete(hf.combine_module_html)
    delete(hf.create_module_html)
    return
  }
}

html_fmt_destroy :: proc() {
  delete(html_fmt.combine_module_html)
  delete(html_fmt.create_module_html)
  delete(html_fmt.delete_module_html)
  delete(html_fmt.module_html)
  delete(html_fmt.index_html)
}

html_fmt_get_index_html :: proc(modules: []string) -> string {
  sb: strings.Builder
  strings.builder_init(&sb)
  defer strings.builder_destroy(&sb)
  module_name: [128]byte

  for module in modules {
    s := fmt.bprintf(module_name[:], INDEX_MODULE_NAME, module, module)
    strings.write_string(&sb, s)
    slice.zero(module_name[:])
  }

  res := fmt.aprintf(html_fmt.index_html, strings.to_string(sb))

  return res 
}

html_fmt_get_module :: proc(module: ^_module.Module) -> string {
  sb: strings.Builder
  strings.builder_init(&sb)
  defer strings.builder_destroy(&sb)

  word_buf: [512]byte

  for w, t in module.content {
    s := fmt.bprintf(word_buf[:], MODULE_WORD_TRANSLATION, w, t, w)
    strings.write_string(&sb, s)
    slice.zero(word_buf[:])
  }

  res := fmt.aprintf(html_fmt.module_html, module.name, strings.to_string(sb))

  return res
}
