#' @export
getBookmarkCount <- function(url){
  require(httr)
  u <- paste0("http://api.b.st-hatena.com/entry.counts?", 
              paste(collapse="&", paste0("url=",url))
              )
  res <- GET(u)
  res <- content(res)
  return(res)
}