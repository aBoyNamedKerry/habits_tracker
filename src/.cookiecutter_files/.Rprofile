# warn on partial matches
options(
  warnPartialMatchAttr = TRUE,
  warnPartialMatchDollar = TRUE,
  warnPartialMatchArgs = TRUE
)

# enable autocompletions for package names in
# `require()`, `library()`
utils::rc.settings(ipck = TRUE)

# warnings are errors
options(warn = 2)

# fancy quotes are annoying and lead to
# 'copy + paste' bugs / frustrations
options(useFancyQuotes = FALSE)
if (interactive()) {
  suppressMessages(require(devtools))
}
options(styler.cache_root = "styler-perm")
