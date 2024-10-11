## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", 
  message = F,
  warning = F
)

## ----packages-used------------------------------------------------------------
library(corpuscleaner)
library(dplyr)
library(tidytext)
library(magrittr)
library(topicmodels)
library(stringr)
library(tidyr)

## -----------------------------------------------------------------------------
novels() %>%
  unnest_tokens(word, 
                text, 
                token = "words") %>%
  anti_join(get_stopwords("en", source = "smart"))

## -----------------------------------------------------------------------------
corpuscleaner::novels_tgt
polish(title == "Wuthering Heights", vars = c("year", "author"))

## -----------------------------------------------------------------------------
# Using novels() to do tf-idf
# Part 1: Finding the commonly used words in all documents
doc_words = novels() %>%
  unnest_tokens(word, text) %>%
  count(title, word, sort = T)

tot_words = doc_words %>%
  group_by(title) %>% 
  summarize(total = sum(n))

put_words = left_join(doc_words, tot_words)
put_words

# Part 2: Using Zipf's law in Finding Word Frequency
frequency_rank = put_words %>%
                    group_by(title) %>%
                    mutate(rank = row_number(),
                           term_frequency = n/total) %>%
                    ungroup()

frequency_rank

## -----------------------------------------------------------------------------
# Using novels to do some Topic Modeling
# Part 1: Find the books you want to use in Topic Modeling 
# Search for Novels that have CHAPTER I... In Them 
novels() %>%
  filter(str_detect(text, "^CHAPTER ")) %>%
  select(title, text)

# Optional: 
# novels() %>%
#   filter(str_detect(text, "^CHAPTER ")) %>%
#   select(title, text) %>%
#   print(n = 250)

book_titles = c("Frankenstein", "Ivanhoe", "The Portrait of a Lady", "Wuthering Heights")

books = novels() %>%
  filter(title %in% book_titles)

# Diving these books by chapter 
book_chapters = books %>%
  group_by(title) %>%
  mutate(chapter = cumsum(str_detect(text, "^CHAPTER "))) %>%
  filter(chapter > 0) %>%
  unite(document, title, chapter)

book_words = book_chapters %>%
  unnest_tokens(word, text) 

book_wordcounts = book_words %>%
  anti_join(get_stopwords("en", source = "smart")) %>%
  count(document, word, sort = T)

book_wordcounts

# Part 2: Convert to LDA for Topic Modeling
book_chapter_DTM = book_wordcounts %>%
                            cast_dtm(document, word, n)

book_chapter_DTM

# Use LDA in Four Topic Modeling given we have Four Documents
book_chapter_LDA = LDA(book_chapter_DTM, k = 4, control = list(seed = 1234))
book_chapter_LDA

# Finally, examine a per topic per word probabilities 
book_topics = tidy(book_chapter_LDA, matrix = "beta")
book_topics

