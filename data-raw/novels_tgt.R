# Note: Make sure when using use_data_raw(name = "novels_tgt) otherwise it will resort to original
# name: DATASET.R

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
# A: Add in the columns that you need in the corpus itself
# Adding in - First_Names: Split the First Names that conjoined
change_names = c("William",
                 "Ann",
                 "Ann",
                 "Matthew",
                 "Jane",
                 "Mary",
                 "Sir Walter",
                 "Edgar Allan",
                 "Emily",
                 "Nathanial",
                 "Elizabeth",
                 "Wilkie",
                 "Charles",
                 "Henry",
                 "Robert Louis",
                 "Robert Louis",
                 "Oscar",
                 "Bram")
# String replace all the First Names conjoined with this new names
manifest$first_name = str_replace_all(manifest$first_name, "[A-z]+", change_names)


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
crps_documents$Last_Name <- paste0(manifest$last_name)
crps_documents$First_Name <- paste0(manifest$first_name)
crps_documents$Year <- paste0(manifest$year)
crps_documents$title <- paste0(manifest$title)

# Remove certain document variables
crps_documents$author <- NULL
crps_documents$datetimestamp <- NULL
crps_documents$description <- NULL
crps_documents$heading <- NULL
crps_documents$id <- NULL
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
crps_tidy_doc = tidy(crps_documents)
# Remove Punctuation and Numbers with Letters
library(stringi)
crps_tidy_doc$text = stringi::stri_replace_all_regex(crps_tidy_doc$text,
                                                     pattern = c("\\p{P}", "\\p{Nd}"),
                                                     replacement = c(" ", " "),
                                                     vectorise_all = F)

str_sub(crps_tidy_doc$text[[9]], start = 1, end = 500)


# After looking at this make author ids and bookshelf (aka genre stuff)
crps_tidy_doc$novel_author_id = c(7,
                                  6,
                                  3,
                                  2,
                                  17,
                                  8,
                                  9,
                                  10,
                                  12,
                                  15,
                                  13,
                                  20,
                                  25,
                                  24,
                                  19,
                                  16,
                                  18,
                                  21)
crps_tidy_doc

crps_tidy_doc = crps_tidy_doc %>%
  relocate(novel_author_id, .after = First_Name)

# Bookshelf
crps_tidy_doc$novels_bookshelf = c("Gothic Fiction",
                                   "Gothic Fiction",
                                   "Gothic Romance Fiction",
                                   "Gothic Fiction",
                                   "Romance Fiction",
                                   "Gothic Fiction",
                                   "Historical Fiction",
                                   "Gothic Fiction",
                                   "Tradegy",
                                   "Gothic Fiction",
                                   "Social",
                                   "Mystery",
                                   "Gothic Fiction",
                                   "Romance Fiction",
                                   "Historical Fiction",
                                   "Fantasy",
                                   "Literary Fiction",
                                   "Gothic Fiction")

crps_tidy_doc = crps_tidy_doc %>%
  relocate(Year, .after = text)
# Hardest Part: Putting all the text relative to novels meaning: The novels themselves
# should not show but you pick a title out and you can get text with it

crps_tidy_doc %>%
  filter(novel_author_id == 21)

# Experiments
# Change the First Name, Last Name, into just the authors in this format
change_authors = c("Beckford, William",
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
crps_tidy_doc$novel_authors = change_authors

crps_tidy_doc = crps_tidy_doc %>%
  select(-c(First_Name, Last_Name))
crps_tidy_doc

crps_tidy_doc = crps_tidy_doc %>%
  relocate(novel_authors, .after = Year)

crps_tidy_doc %>%
  filter(novel_authors == "Wilde, Oscar")

crps_tidy_doc = crps_tidy_doc %>%
  rename(novel_year = Year)

# Process: Extracting title, author and text into tibbles of two columns: title | text
# Extracting Author|Sentences
WH = str_extract_all(crps_tidy_doc$text[[9]], "(?:[A-z.]+ )+")
WH = unlist(WH)

# CORRECT Regex Expression
# regex("(?:[A-z.]+ )+")
# Note - IMPORTANT: This regex expression gets you all the sentences without punctuation next to it and
# deliminits it for you - VERY USEFUL IN GETTING ALL THE WORDS YOU NEED.

# Tibble it into just two variables
WF = tibble(title = "Wuthering Heights", text = WH, year = 1847, author = "Bronte, Emily",
            novel_bookshelf = "Tragedy")

# VATHEK
# Extracting Author|Sentences
V = str_extract_all(crps_tidy_doc$text[[1]], "(?:[A-z.]+ )+")
V = unlist(V)

# Tibble it into just three variables
TF = tibble(title = "Vathek", text = V, year = 1786, author = "Beckford, William",
            novel_bookshelf = "Gothic Fiction")

# TREASURE ISLAND
# Extracting Author|Sentences
TI = str_extract_all(crps_tidy_doc$text[[15]], "(?:[A-z.]+ )+")
TI = unlist(TI)

# Tibble it into just two variables
TIF = tibble(title = "Treasure Island", text = TI, year = 1882, author = "Stevenson, Robert Louis",
             novel_bookshelf = "Historical Fiction")

# The Picture of Dorian Gray
DG = str_extract_all(crps_tidy_doc$text[[17]], "(?:[A-z.]+ )+")
DG = unlist(DG)

GF = tibble(title = "The Picture of Dorian Gray", text = DG, year = 1890, author = "Wilde, Oscar",
            novel_bookshelf = "Literary Fiction")

# Frankestein
FT = str_extract_all(crps_tidy_doc$text[[6]], "(?:[A-z.]+ )+")
FT = unlist(FT)

FG = tibble(title = "Frankenstein", text = FT, year = 1818, author = "Shelley, Mary",
            novel_bookshelf = "Gothic Fiction")

# A Sicilian Romance
SR = str_extract_all(crps_tidy_doc$text[[2]], "(A Sicilian Romance|by Ann Radcliffe)|(?:[A-z.]+ )+")
SR = unlist(SR)

SO = tibble(title = "A Sicilian Romance", text = SR, year = 1790, author = "Radcliffe, Ann",
            novel_bookshelf = "Gothic Fiction")


# The Mysteries of Udoplho
MU = str_extract_all(crps_tidy_doc$text[[3]], "(?:[A-z.]+ )+")
MU = unlist(MU)

MF = tibble(title = "The Mysteries of Udolpho", text = MU, year = 1794, author = "Radcliffe, Ann",
            novel_bookshelf = "Gothic Romance Fiction")

# The Monk: A Romance
TM = str_extract_all(crps_tidy_doc$text[[4]], "(?:[A-z.]+ )+")
TM = unlist(TM)

AF = tibble(title = "The Monk: A Romance", text = TM, year = 1795, author = "Lewis, Matthew",
            novel_bookshelf = "Gothic Fiction")


# Sense and Sensibility
SS = str_extract_all(crps_tidy_doc$text[[5]], "(?:[A-z.]+ )+")
SS = unlist(SS)

SF = tibble(title = "Sense and Sensibility", text = SS, year = 1811, author = "Austen, Jane",
            novel_bookshelf = "Romance Fiction")


# Ivanhoe: A Romance
IV = str_extract_all(crps_tidy_doc$text[[7]], "(?:IVANHOE  A ROMANCE|By Sir Walter Scott)|(?:[A-z.]+ )+")
IV = unlist(IV)

NF = tibble(title = "Ivanhoe", text = IV, year = 1820, author = "Scott, Sir Walter",
            novel_bookshelf = "Historical Fiction")


# Narrative of A. Gordon Pym
GP = str_extract_all(crps_tidy_doc$text[[8]], "(?:[A-z.]+ )+")
GP = unlist(GP)

PF = tibble(title = "Narrative of Arthur Gordon Pym", text = GP, year = 1838, author = "Poe, Edgar Allan",
            novel_bookshelf = "Gothic Fiction")


# The House of Seven Gables
crps_tidy_doc$text[[10]] = str_replace_all(crps_tidy_doc$text[[10]], "THE HOUSE OF THE SEVEN GABLES   by  NATHANIEL HAWTHORNE   ", " ")
str_sub(crps_tidy_doc$text[[10]], start = 1, end = 1000)
# Remove duplicate title

SG = str_extract_all(crps_tidy_doc$text[[10]], "(?:[A-z.]+ )+")
SG = unlist(SG)

EF = tibble(title = "The House of Seven Gables", text = SG, year = 1851, author = "Hawthorne, Nathaniel",
            novel_bookshelf = "Gothic Fiction")


# North and South
NS = str_extract_all(crps_tidy_doc$text[[11]], "(?:[A-z.]+ )+")
NS = unlist(NS)

OF = tibble(title = "North and South", text = NS, year = 1854, author = "Gaskell, Elizabeth",
            novel_bookshelf = "Social")


# The Woman in White
WW = str_extract_all(crps_tidy_doc$text[[12]], "(?:[A-z.]+ )+")
WW = unlist(WW)

HF = tibble(title = "The Woman in White", text = WW, year = 1860, author = "Collins, Wilkie",
            novel_bookshelf = "Mystery")


# Great Expectations
GE = str_extract_all(crps_tidy_doc$text[[13]], "(?:[A-z.]+ )+")
GE = unlist(GE)

XF = tibble(title = "Great Expectations", text = GE, year = 1861, author = "Dickens, Charles",
            novel_bookshelf = "Gothic Fiction")


# The Portrait of a Lady
PS = str_extract_all(crps_tidy_doc$text[[14]], "(?:[A-z.]+ )+")
PS = unlist(PS)

POF = tibble(title = "The Portrait of a Lady", text = PS, year = 1881, author = "James, Henry",
             novel_bookshelf = "Romance Fiction")


# The Strange Case of Dr. Jekyll and Hyde
JH = str_extract_all(crps_tidy_doc$text[[16]], "(?:[A-z.]+ )+")
JH = unlist(JH)

JF = tibble(title = "Dr Jekyll and Hyde", text = JH, year = 1886, author = "Stevenson, Robert Louis",
            novel_bookshelf = "Fantasy")


# Dracula
DR = str_extract_all(crps_tidy_doc$text[[18]], "(?:[A-z.]+ )+")
DR = unlist(DR)

DF = tibble(title = "Dracula", text = DR, year = 1897, author = "Stoker, Bram",
            novel_bookshelf = "Gothic Fiction")

novels_tgt = bind_rows(AF,
                       DF,
                       EF,
                       FG,
                       GF,
                       HF,
                       JF,
                       MF,
                       NF,
                       OF,
                       PF,
                       POF,
                       SF,
                       SO,
                       TF,
                       TIF,
                       WF,
                       XF)

novels_tgt$text = str_trim(novels_tgt$text, "both")
novels_tgt
usethis::use_data(novels_tgt, compress = "bzip2", overwrite = TRUE)
