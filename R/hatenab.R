#' @export
getBookmarkCount <- function(url){
  require(httr)
  counts <- length(url)
  if(counts < 50){
    u <- paste0("http://api.b.st-hatena.com/entry.counts?", 
                paste(collapse="&", paste0("url=",url))
    )
    res <- GET(u)
    res <- httr::content(res)
  } else{
    loops <- trunc(counts/50)+1
    res <- NULL
    for(l in seq(loops)){
      nums <- seq(1+50*(l-1), ifelse(l*50>counts, counts, l*50))
      url0 <- url[nums]
      u <- paste0("http://api.b.st-hatena.com/entry.counts?", 
                  paste(collapse="&", paste0("url=",url0))
      )
      res0 <- GET(u)
      res <- c(res, httr::content(res0))
      Sys.sleep(0.5)
    }
   }
  res <- unlist(res)
  res <- data.frame(page=names(res), count=unname(res), stringsAsFactors=FALSE)
  return(res)    
}