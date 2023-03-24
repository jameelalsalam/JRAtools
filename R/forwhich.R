# forwhich.R

#' Return the scalar of a vector
#'
#' @examples
#' one(c(1))
#' one(numeric(0))
#' typeof(one(numeric(0)))
#' \dontrun {
#' one(c(1, 2))
#' }
#' @export
one <- function(x) {
  if (length(x) == 1) x else
    # NA value typed the same as x
    if (length(x) == 0) x[NA] else
      stop("Input `x` to `one` function must not have length > 1")
}

#' Return a single value from a vector, for which a different condition holds
#'
#' Intended to help with EAV calculations that potentially have length 0, ruining data frame operations.
#'
#' Use case discussion here: https://community.rstudio.com/t/right-way-to-do-grouped-with-dplyr/1501
#'
#' @param x a vector from which to return results
#' @param p a vector of booleans (or other `[` indices?) length of x
#' @examples
#' tidyr::population %>%
#'   dplyr::group_by(country) %>%
#'   dplyr::summarize(chg_2000_to_2012 =
#'     (population %forwhich% (year == 2012)) /
#'     (population %forwhich% (year == 2000)),
#'     .groups = "drop")
#'
#' @export
`%forwhich%` <- function(x, p) {
  one(x[p])
}
