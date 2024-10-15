setwd("C:/Users/tfop2/OneDrive/Documents/Anshal_Majmudar_R_Packages")

# Download the librarian package
# Load all the packages neccesary for corpus work
librarian::shelf(quanteda, dplyr, stringr, rio, tm, tidytext, tidyr, stringi)

# Part 1 - Observing the Data
# Import the csv file of all the novels
manifest = import("C19_novels_manifest.csv")
manifest

glimpse(manifest)

# Change genre into a factor variable
manifest = manifest %>%
  mutate(genre = factor(manifest$genre))

# Read in the RDS
files = readRDS("C19_novels_raw.rds")

# Optional
# class(files)
# files
# head(files[[1]])
# The list is vectorized - a long vector

# Changing the vector so it's not all chunks of text - it's one stream of text
# Blobbing the Text - Making all the text one long blob
files = lapply(files, paste, collapse = " ") # Collapse a single space

# Optional
# files[[1]]
# length(files[[1]])

# Text Mining - Corpus
# Creating the Corpus - Defines all the text you're looking at
corpus = Corpus(VectorSource(files))
corpus # 18 Total Documents
corpus[[6]] # Shows there are 424017 characters in the sixth novel in the dataset

glimpse(corpus)
tmp = corpus$content
class(tmp)
length(tmp)

# Note: This is how to convert a tm file into a "quanteda" file
# Part 2: Work with the corpus first and clean it up
# A: Convert the tm Corpus files into a quanteda corpus files
crps = tm::VCorpus(tm::VectorSource(files))
crps = corpus(crps)
ndoc(crps) # Check number of documents - shows there are 18 documents

# Turn it all into sentences and check new number of documents
crps_sentences = corpus_reshape(crps, to = "sentences")
print(crps_sentences)

ndoc(crps_sentences) # 122108 documents

# Restore it back to documents and check if its the same as the original amount of ndoc
crps_documents = corpus_reshape(crps_sentences, to = "documents")
print(crps_documents)
ndoc(crps_documents)

# Optional
# Apply corpus subset to keep long sentences (more than 10 words)
# crps_sentences_long = corpus_subset(crps_sentences, ntoken(crps_sentences) >= 10)
# ndoc(crps_sentences_long) # 94146 documents
#
# Restore it back to documents and check if its the same as the original amount of ndoc
# crps_documents_long = corpus_reshape(crps_sentences_long, to = "documents")
# print(crps_documents_long)
# ndoc(crps_documents_long)

# Changing Document Variables and Their Content
# Adding In the Titles: Split the titles that are conjoined
change_titles = c("Vathek",
                  "A Sicilian Romance",
                  "The Mysteries of Udulpho",
                  "The Monk: A Romance",
                  "Sense and Sensibility",
                  "Frankenstein",
                  "Ivanhoe",
                  "Narrative of Arthur Gordon Pym",
                  "Wuthering Heights",
                  "The House of Seven Gables",
                  "North and South",
                  "The Woman in White",
                  "Great Expectations",
                  "The Portrait of a Lady",
                  "Treasure Island",
                  "Dr Jekyll and Hyde",
                  "The Picture of Dorian Gray",
                  "Dracula")
# String replace all the titles conjoined with this new titles
manifest$title = str_replace_all(manifest$title, "[A-z\\:]+", change_titles)

# Now Add in and Paste the New Document Variables
crps_documents$year <- paste0(manifest$year)
crps_documents$title <- paste0(manifest$title)

# Remove certain document variables
crps_documents$author <- c("Beckford, William",
                           "Radcliffe, Ann",
                           "Radcliffe, Ann",
                           "Lewis, Matthew",
                           "Austen, Jane",
                           "Shelley, Mary",
                           "Scott, Sir Walter",
                           "Poe, Edgar Allan",
                           "Bronte, Emily",
                           "Hawthorne, Nathanial",
                           "Gaskell, Elizabeth",
                           "Collins, Wilkie",
                           "Dickens, Charles",
                           "James, Henry",
                           "Stevenson, Robert Louis",
                           "Stevenson, Robert Louis",
                           "Wilde, Oscar",
                           "Stoker, Bram")
crps_documents$datetimestamp <- NULL
crps_documents$description <- NULL
crps_documents$heading <- NULL
crps_documents$language <- NULL
crps_documents$origin <- NULL

# Check to see it worked
docvars(crps_documents)

# B: Renaming the document variables
doc_id = paste(manifest$year,
               manifest$last_name,
               sep = "-")

docnames(crps_documents) = doc_id
crps_documents

# See a summary of the corpus to see it worked
summary(crps_documents)

# Part 2: Tidying the corpus using tidytext
# Tidy the corpus to turn it into a tibble
Documents = tidy(crps_documents)
Documents = Documents %>%
  relocate(title, .before = text)
Documents = Documents %>%
  relocate(author, .after = year)
Documents = Documents %>%
  relocate(id, .before = title)
# Remove Punctuation and Numbers with Letters
library(stringi)
Documents$text = stringi::stri_replace_all_regex(Documents$text,
                                                     pattern = c("\\p{P}", "\\p{Nd}"),
                                                     replacement = c(" ", " "),
                                                     vectorise_all = F)

# Hardest Part: Putting all the text relative to novels meaning: The novels themselves
# should not show but you pick a title out and you can get text with it
Documents$text = str_squish(Documents$text)
Documents$text = tolower(Documents$text)
Documents

#' @name Documents
#' @docType data
#' @title Dataset of 18 Cleaned Documents
#' @description A Tibble of 18 Cleaned Documents usable for Corpus Analysis
#' @format A \code{tibble} with 369111 rows and 5 variables consisting of:
#' \describe{
#'  \item{id}{ID of Documents}
#'  \item{title}{Title of Documents}
#'  \item{text}{Text of Documents}
#'  \item{year}{Year Published}
#'  \item{authors}{Authors of Documents}
#' }
#' @keywords dataset
"Documents"
