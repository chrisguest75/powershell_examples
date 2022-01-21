# README

A quick little script to help cheat on Wordle.  

TODO:  

* Create some statistics on words


## Create the 5 letter word list

```ps1
(./filter-list.ps1 -create -min 5 -max 5 -path ./words.txt) | convertto-json | out-file 5letterwordsdoubles.txt
```

## Play game

```ps1
# dotsource the functions
. ./play-game.ps1   

# load the words
$words = load-words -path "./5letterwordsdoubles.txt"

# suggest first words
first-words -words $words 

# use first word (use taken if letters were not selected)
next-words -words $words -taken "audio"

# use regex to determine where characters are
next-words -words $words -taken "audihusecky" -position "^r.*"

```