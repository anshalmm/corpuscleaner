#' @title Documents Extraction
#' @name document_by_ID
#' @description
#' This function allows you to extract the document of your choice based on the title you choose along with
#' any extra parameters you'd like to see with it such as the `year` or the `author`.
#' @return A \code{tibble} with `id`, and then any column variable of your choice
#' @param ... Input any ID (i.e., 1:18) from the `Documents` dataset
#' @param vars Input any column variable from the `Documents` dataset
#' @export
#' @importFrom dplyr group_by
#' @importFrom dplyr filter
#' @importFrom dplyr select
#' @importFrom rlang .data
#' @importFrom magrittr %>%
#' @examples
#' document_by_ID(id == 11, vars = c("year", "author"))
document_by_ID = function(...){
  suppressMessages(Documents %>%
                     dplyr::filter(...) %>%
                     dplyr::group_by(.data$id) %>%
                     dplyr::select(id, title, text, year, author))
}
