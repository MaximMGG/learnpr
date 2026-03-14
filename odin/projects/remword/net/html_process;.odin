package net


import "core:os"


INDEX_MODULE_NAME :: "<li><a class=\"module-link\" href=\"module.html\">%s</a></li>"

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
  index_file, index_ok := os.read_entire_file("./html/index.html")
  if !index_ok {
 
  }

}

html_fmt_destroy :: proc() {
  delete(html_fmt.combine_module_html)
  delete(html_fmt.create_module_html)
  delete(html_fmt.delete_module_html)
  delete(html_fmt.module_html)
  delete(html_fmt.index_html)
}


