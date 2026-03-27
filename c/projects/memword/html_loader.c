#include "html_loader.h"

#define COMBINE_MODULE_HTML 0
#define CREATE_MODULE_HTML 1
#define DELETE_MODULE_HTML 2
#define INDEX_HTML 3
#define MODULE_HTML 4

#define MODULE_FMT "<li><a class=\"module-link\" href=\"%s\">%s</a></li>\n"

#define TRANSLATION_FMT "<tr>\n"				\
  "<td>%s</td>\n"								\
  "<td>%s</td>\n"								\
  "<td>\n"																\
  "<form class=\"inline-form\" action=\"/delete_word\" method=\"post\">\n" \
  "<input type=\"hidden\" name=\"word\" value=\"%s\">\n"				\
  "<input type=\"submit\" class=\"delete-btn\" value=\"✖\">\n"			\
  "</form>\n"															\
  "</td>\n"																\
  "/tr>\n"

str files[] = {"combine-modules.html",
			   "create-module.html",
			   "delete-module.html",
			   "index.html",
			   "module.html"};

str *content;

i32 fds[5] = {0};

void initHtml() {
  content = make_many(str, 5);
  for(i32 i = 0; i < 5; i++) {
	fds[i] = open(files[i], O_RDONLY);
	if (fds[i] <= 0) {
	  fprintf(stderr, "Con't open %s\n", files[i]);
	  dealloc(content);
	  return;
	}
  }

  for(i32 i = 0; i < 5; i++) {
	struct stat st;
	fstat(fds[i], &st);

	content[i] = alloc(st.st_size + 1);
	memset(content[i], 0, st.st_size + 1);
	i32 read_bytes = read(fds[i], content[i], st.st_size);
	if (read_bytes != st.st_size) {
	  fprintf(stderr, "Can't read from file %s\n", files[i]);
	  dealloc(content[i]);
	  dealloc(content);
	}
  }
  for(i32 i = 0; i < 5; i++) {
	close(fds[i]);
  }
}

void deinitHtml() {
  for(i32 i = 0; i < 5; i++) {
	dealloc(content[i]);
  }
  dealloc(content);
}

str loadIndexHtml(List *modules) {
  strbuf *sb = strbufCreate();

  for(u32 i = 0; i < modules->len; i++) {
	str module_name = listGet(modules, i);

	str new_module = strCreateFmt(MODULE_FMT, module_name, module_name);
	strbufAppend(sb, new_module);
	dealloc(new_module);
  }

  str modules_str = strbufToString(sb);
  str index_html = strCreateFmt(content[INDEX_HTML], modules_str);
  dealloc(modules_str);

  strbufDestroy(sb);
  return index_html;
}

str loadModuleHtml(str module_name, Map *cont) {
  strbuf *sb = strbufCreate();
  Iterator *it = mapIterator(cont);

  while(mapItNext(it)) {
	str word = it->key;
	str translation = it->val;

	str tmp = strCreateFmt(TRANSLATION_FMT, word, translation, word);
	strbufAppend(sb, tmp);
	dealloc(tmp);
	
  }
  mapItDestroy(it);
  str module_html_cont = strbufToString(sb);
  str module_html = strCreateFmt(content[MODULE_HTML], module_name, module_html_cont);
  dealloc(module_html_cont);

  strbufDestroy(sb);

  return module_html;
}

str loadCreateModuleHtml() {
  return strCopy(content[CREATE_MODULE_HTML]);
}

str loadCombineModuleHtml() {
  return strCopy(content[COMBINE_MODULE_HTML]);
}

str loadDeleteModuleHtml() {
  return strCopy(content[DELETE_MODULE_HTML]);
}
