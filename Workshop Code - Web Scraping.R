##### RDS@GSU - WEB SCRAPING WITH R (AND PYTHON) #####

##### Copyright + References #####
# The content in this notebook was developed by Jeremy Walker.
# All sample code and notes are provided under a Creative Commons
# ShareAlike license.

# Official Copyright Rules / Restrictions / Priveleges
# Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
# https://creativecommons.org/licenses/by-sa/4.0/


##### HOUSE KEEPING #####
# Before you get started, you should make sure you...

# 1) Click on the "File" menu and and then "Save as" 
# to save the R file in the desired location on your computer.

# 2) Click on the "Session" menu and "Set Working Directory" 
# to "To Source File Location".


##### WORKSHOP NOTES #####
# All of this content was created in July 2020.
# Depending on when this content is access and
# due to the nature of how individual websites 
# change their code, the code in this file 
# may not function properly in the future.


##### WHAT WE'RE BUILDING TOWARDS... #####
# A scripted "program" that, when activated, will automatically
# go to a specific website, collect multiple documents, and save
# said documents to your local computer:
###
### library(rvest)
### scraper <- function(starting_url , count){
###   website <- starting_url
###   website_html <- read_html(x = website)
###   results <- website_html %>%
###     html_nodes(css = ".collection-results") %>% 
###     html_nodes(css = "li") %>% 
###     html_nodes(css = "a")
###   links <- results %>% html_attr("href")
###   page_counter <- count
###   for (page in links) {
###     webpage <- read_html(x = page)
###     filename <- paste0( "web_documents/" , page_counter , ".html" )
###     write_html(x = webpage, file = filename)
###     page_counter <- page_counter + 1
###   if (length(html_nodes(x = website_html,css = ".next.page-numbers")) == 1) {
###     next_url <- website_html %>% 
###       html_nodes(css = ".next.page-numbers") %>% 
###       html_attr("href")
###     if (page_counter < 30) {
###       scraper(starting_url = next_url, count = page_counter)
###     }
###   }
### }
### scraper(starting_url="https://www.state.gov/press-releases/", count=0)
###


##### Part 0 - Install and load the "Rvest" package. #####
install.packages("rvest")
library(rvest)


##### Part 1 - Getting a webpage and saving it locally #####

# Specify a webpage
state_dept <- 'https://www.state.gov/press-releases/'

# Using the Rvest module, the "read_html" function
# allows us to use Python to fetch the webpage
webpage <- read_html(x = state_dept)

# The webpage object is structured as an XML document 
# where every tag and node is nested within its parent
# node (similar to how plants branch and grow)
View(webpage)

# The "paste0" function will concatenate strings, 
# numbers, and some other data types into a single 
# string without spaces.
filename <- paste0( "web_documents/" , "press_release_directory" , ".html" )
filename

# The "write_html" function will take a webpage/html
# object ("x = ") and save it to a specified file and filename
# on the computer ("file = ").
write_html(x = webpage, file = filename)



##### Part 1 - Recap #####

# Load Rvest
library(rvest)
# Specify a webpage
state_dept <- 'https://www.state.gov/press-releases/'
# Get webpage
webpage <- read_html(x = state_dept)
# Create filename
filename <- paste0( "web_documents/" , "press_release_directory" , ".html" )
# Save webpage
write_html(x = webpage, file = filename)



##### Part 1 - Practice #####
# The code below uses the same code as above, but with ???
# replacing many key areas. You can practice by simply replicating
# what is above.  Or you can also try using a different URL, 
# saving the file with a different name, or even changing the 
# names of individual objects/variables.

# # Load Rvest
# library(???)
# 
# # Specify a webpage
# state_dept <- '???'
# 
# # Get the webpage and assign it to a "webpage" object
# ??? <- read_html(x = ???)
# 
# # Create filename
# filename <- paste0( "web_documents/" , "???" , ".html" )
# 
# # Save the webpage - specify the filename
# write_html(x = ???, file = ???)




##### Part 2 - Navigating HTML code #####

#### First Objective - Extracting the list of links
#
# Rvest, as mentioned above, automatically 
# organized HTML documents into a structured 
# node/tree type of object.  Using functions 
# built into the Rvest package, we can easily 
# parse, navigate, and dissect information on 
# the webpage.

# Load Rvest
library(rvest)
# Specify a webpage
state_dept <- 'https://www.state.gov/press-releases/'
# Get webpage
webpage <- read_html(x = state_dept)
# Create filename
filename <- paste0( "web_documents/" , "press_release_directory" , ".html" )
# Save webpage
write_html(x = webpage, file = filename)

 # Using the "html_node" function, find the node the 
# first tag matching the specified tag name or CSS label.
# 
# Example: finding the first "meta" tag in the soup
html_node(x = webpage, "meta")

# "html_nodes" is similar, except that it returns a
# list of all nodes with matching criteria, not just
# the first.
html_nodes(x = webpage, "meta")

# Find all "p" nodes
html_nodes(x = webpage, "p")

# Find all "li" nodes
html_nodes(x = webpage, "li") 

# "p" and "li" and "div" are examples of HTML tags.
# You can also navigate the HTML object by searching
# for CSS attributes such as "classes" and "IDs".

# Search nodes by class name (the "." is important):
# html_nodes(x = webpage, css = ".classname")
html_nodes(x = webpage, css = ".collection-results") 

# Search nodes by ID name (the "#" is important):
# html_nodes(x = webpage, css = "#ID_name") 
html_nodes(x = webpage, css = "#col_json_result")

# Two methods are available for chaining node/nodes
# searches together.  The first is to simply create
# new objects and perform subsequent operations:
object1 <- html_nodes(x = webpage, css =".collection-results")
object1

object2 <- html_nodes(x = object1, css = "li")
object2

object3 <- html_nodes(x = object2, css = "a")
object3

results <- object3

# The second method is to use a "pipe" approach
# which is standard in Tidyverse (including Rvest)
# packages.  For more information on "pipe", see
# the magrittr documentation: https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html

# Single-line formatting:
webpage %>% html_nodes(css = ".collection-results") %>% html_nodes(css = "li") %>% html_nodes(css = "a")

# Tidy formatting:
webpage %>% 
  html_nodes(css = ".collection-results") %>% 
  html_nodes(css = "li") %>% 
  html_nodes(css = "a")

# Tidy format, assigned to new "results" object:
results <- webpage %>%
  html_nodes(css = ".collection-results") %>% 
  html_nodes(css = "li") %>% 
  html_nodes(css = "a")


##### Part 2 - First Objective - Recap #####
# Load Rvest
library(rvest)
# Specify a webpage
state_dept <- 'https://www.state.gov/press-releases/'
# Get webpage
webpage <- read_html(x = state_dept)
# Create filename
filename <- paste0( "web_documents/" , "press_release_directory" , ".html" )
# Save webpage
write_html(x = webpage, file = filename)
# Get a list
results <- webpage %>%
  html_nodes(css = ".collection-results") %>% 
  html_nodes(css = "li") %>% 
  html_nodes(css = "a")


##### Part 2 - Second Objective - Extracting data and hyperlinks from results list ##### 
# For each node in the results, "html_text" will
# return the text displayed on the webpage
html_text(x=results)
results %>% html_text()

# The attributes and metadata can be retrieved
# using "html_attrs".  In this case, each of the
# links has an "href" and "class" attribute.
html_attrs(x=results)
results %>% html_attrs()

# Individual attributes can be extracted using "html_attr"
html_attr(x=results, "href")
results %>% html_attr("href")

# Using this approach, assign the list of links to a new object
links <- results %>% html_attr("href")

# Lastly, these links to individual press releases
# can be used to collect the individual press release
# webpages using the methods above.

# The links object is just a list or vector.
links

# Individual items can be called to perform individual operations.
links[1]

# Like above, we can repeat the process for 
# collecting a new webpage, creating a filename, 
# and saving it to the computer.

# Get webpage
webpage <- read_html(x = links[1])
# Create filename
filename <- paste0( "web_documents/" , "first_webpage" , ".html" )
# Save webpage
write_html(x = webpage, file = filename)


##### Part 2 - Practice ##### 
# # The code below uses the same code as above, but with 
# # ??? replacing many key areas. You can practice by simply
# # replicating what is above.  Or you can also try using 
# # a different URL, saving the file with a different name,
# # or even changing the names of individual objects/variables.


# # The main goal is to (A) get a webpage that as a list ("li")
# # of items, (B) extracting the URLs ("a") as a list of results
# # from said webpage, and then (C) get and save a new webpage
# # using one of the links from the list of results.


# # Getting started with the correct "webpage" object...
# library(rvest)
# state_dept <- 'https://www.state.gov/press-releases/'
# webpage <- read_html(x = state_dept)
# 
# 
# # Create a "results" object that contains a list of the "a"
# # tags that represent URLs to individual press releases.
# results <- webpage %>%
#   html_nodes(css = "???") %>% 
#   html_nodes(css = "???") %>% 
#   html_nodes(css = "???")
# 
# # Show the "results" to make sure you have the correct list.
# results
# 
# # Extract URLs ("href") links from results list
# links <- results %>% html_attr("???")
# 
# # Get the webpage for the first URL
# webpage <- read_html(x = ???[?])
# 
# # Create filename
# filename <- paste0( "web_documents/" , "???" , ".html" )
# 
# # Save the webpage
# write_html(x = ???, file = ???)



##### Part 3 - Iterating Through Content #####

# Load Rvest
library(rvest)
# Specify a webpage
state_dept <- 'https://www.state.gov/press-releases/'
# Get webpage
webpage <- read_html(x = state_dept)
# Create filename
filename <- paste0( "web_documents/" , "press_release_directory" , ".html" )
# Save webpage
write_html(x = webpage, file = filename)
# Get a list
results <- webpage %>%
  html_nodes(css = ".collection-results") %>% 
  html_nodes(css = "li") %>% 
  html_nodes(css = "a")
# Extract URL links from results list
links <- results %>% html_attr("href")

# The links object is a list of individual URLs.
links

# In order to collect each individual webpage in the links list,
# we will use a for-loop to iterate through each item in the list.
# For-loops can be a bit tricky to understand if you are new to 
# programming and scripting.  However, there are many excellent
# guides and tutorials on the web for this:

# For Loops Tutorials
# https://www.tutorialspoint.com/r/r_for_loop.htm
# https://www.r-bloggers.com/how-to-write-the-first-for-loop-in-r/


# The following lines of code highlight a few examples of
# using for loops.

# This example can be read as "For every item ('i') in a list 
# ('list_of_items'), display ('print()') the item ('i').

list_of_items <- c("a","b","c","d")

for (i in list_of_items) {
  print(i)
}

# While 'i' is a common placeholder for items when iterating
# through a list, it is arbitrary.  Any other placeholder will
# function exactly the same.

list_of_items <- c("a","b","c","d")

for (x in list_of_items) {
  print(x)
}

for (banana in list_of_items) {
  print(banana)
}

# While for-loops are usually used to perform
# some function or operation on a different item,
# that is not strictly required.  Python will do
# an arbitrary task for each iteration.

for (banana in list_of_items) {
  print("oranges")
}

# Returning to the links object, the following
# code iterates through each link and displays
# the tag.

for (page in links) {
  print("PAGE URL")
  print(page)
}


# For loops can also modify existing objects. For example,
# we can create an object that simply increases by 1 for
# every iteration in the for loop.

page_counter <- 0

for (page in links) {
  print(page_counter)
  page_counter <- page_counter + 1
}

# Expand the for-loop to include both the counter and
# the hyperlink ("href").

page_counter <- 0

for (page in links) {
  print(page_counter)
  print(page)
  page_counter <- page_counter + 1
}


# Altogether, we can create a for-loop
# that iterates through the results list, collects each
# individual webpage and saves them using an enumerated
# filename.

page_counter <- 0

for (page in links) {
  
  # Specify a webpage
  webpage <- read_html(x = page)
  
  # Create filename using the page_counter
  filename <- paste0( "web_documents/" , page_counter , ".html" )
  
  # Save webpage
  write_html(x = webpage, file = filename)
  
  # Sanity-check: print out the URL and current page_counter
  print(page_counter)
  print(page)
  
  # Update the page_counter
  page_counter <- page_counter + 1
}

##### Part 3 - Recap #####
# Load Rvest
library(rvest)
# Specify a webpage
state_dept <- 'https://www.state.gov/press-releases/'
# Get webpage
webpage <- read_html(x = state_dept)
# Create filename
filename <- paste0( "web_documents/" , "press_release_directory" , ".html" )
# Save webpage
write_html(x = webpage, file = filename)
# Get a list
results <- webpage %>%
  html_nodes(css = ".collection-results") %>% 
  html_nodes(css = "li") %>% 
  html_nodes(css = "a")
# Extract URL links from results list
links <- results %>% html_attr("href")
# Initiate counter
page_counter <- 0
# For Loop
for (page in links) {
  # Specify a webpage
  webpage <- read_html(x = page)
  # Create filename using the page_counter
  filename <- paste0( "web_documents/" , page_counter , ".html" )
  # Save webpage
  write_html(x = webpage, file = filename)
  # Sanity-check: print out the URL and current page_counter
  print(page_counter)
  print(page)
  # Update the page_counter
  page_counter <- page_counter + 1
}


##### Part 4 - Creating a Function to Wrap Everything Together #####

# In order to to simplify how the code above is
# displayed and used, we will encapsulate the
# script within a "function".  There is a lot
# to learn regarding exactly how Functions work,
# but that is beyond the scope of this workshop.
# For this section, we'll focus on using simple
# and straigthforward mechanics of Functions.

# Functions Tutorials
# https://www.tutorialspoint.com/r/r_functions.htm
# https://www.statmethods.net/management/userfunctions.html

# For example, the following function ("FunctionName") 
# takes two parameters.  In truth, you can define a
# function to take any number of parameters or none
# at all.  The function then does whatever operations
# you instruct.

FunctionName <- function(parameter1 , parameter2){
  # Do something, anything within the function...
  xyz <- parameter1 + 500
  abc <- xyz + parameter2
  print(abc)
}

# Once the function has been defined, we can
# call or use that function just like any of
# the other functions we've used.

FunctionName(parameter1=500, parameter2=1000)

FunctionName(parameter1=141, parameter2=1024)


# Building from there, we can create a function
# that will encapsulate everything we've done so 
# far with web-scraping.

scraper <- function(starting_url , count){
  # insert appropriate lines of code here
  print()
}
  
# Putting it all together, the function below will
# use the starting_url we provide and the count we 
# provide to go to a website, collect all of the URLs
# for individual Press Release documents, then download
# and save individual documents.


scraper <- function(starting_url , count){
  
  # Specify a website
  website <- starting_url
  
  # Get website html
  website_html <- read_html(x = website)
  
  # Get a list
  results <- website_html %>%
    html_nodes(css = ".collection-results") %>% 
    html_nodes(css = "li") %>% 
    html_nodes(css = "a")
  
  # Extract URL links from results list
  links <- results %>% html_attr("href")
  
  # Initiate counter
  page_counter <- count
  
  # For Loop
  for (page in links) {
    
    # Specify a webpage
    webpage <- read_html(x = page)
    
    # Create filename using the page_counter
    filename <- paste0( "web_documents/" , page_counter , ".html" )
    
    # Save webpage
    write_html(x = webpage, file = filename)
    
    # Update the page_counter
    page_counter <- page_counter + 1
  }
}

# Lastly, call or execute the script!
scraper(starting_url="https://www.state.gov/press-releases/", count=0)




##### Part 4 - But wait, there's more!! #####

# In addition to writing a function to excecute a single
# set of commands, we can also set up the function in such
# a way that it repeats itself multiple times.  This is
# useful because now we can expand the function in a way
# that allows us to go to the "next page" on the Press
# Releases webpage and collect more and more documents.


# The following comment is an oversimplified example of
# a function executing some code and then calling itself
# again to repeat the same code.

# def scraper (parameters...):
#     code code code
#     code code code
#     scraper(parameters...)

# The following function has a fully fleshed out example 
# of this addition.


# Load Rvest
library(rvest)

# Define the function
scraper <- function(starting_url , count){
  
  # Specify a website
  website <- starting_url
  
  # Get website html
  website_html <- read_html(x = website)
  
  # Get a list
  results <- website_html %>%
    html_nodes(css = ".collection-results") %>% 
    html_nodes(css = "li") %>% 
    html_nodes(css = "a")
  
  # Extract URL links from results list
  links <- results %>% html_attr("href")
  
  # Initiate counter
  page_counter <- count
  
  # For Loop
  for (page in links) {
    
    # Specify a webpage
    webpage <- read_html(x = page)
    
    # Create filename using the page_counter
    filename <- paste0( "web_documents/" , page_counter , ".html" )
    
    # Save webpage
    write_html(x = webpage, file = filename)
    
    # Update the page_counter
    page_counter <- page_counter + 1
  }
  
  #     The following block of code adds recursion to the function.
  #     First -  It uses html_nodes to search for the "next" button
  #              by looking for css = ".next.page-numbers".
  #     Second - If the length of the returned result == 1 (i.e. there
  #              is a "next" button), then it creates a next_url object 
  #              by extracting the URL/href from the "next" button.
  #     Third -  It checks the current value of page_counter.  If the value
  #              is less than 30, it calls the "scraper()" function again
  #              and passes the next_url and page_counter parameters 
  #              and the WHOLE scraper function repeats itself.
  #     Fourth - If page_counter is equal to or greater than 30, the 
  #              scraper() function stops.
  
  if (length(html_nodes(x = website_html,css = ".next.page-numbers")) == 1) {
    next_url <- website_html %>% 
      html_nodes(css = ".next.page-numbers") %>% 
      html_attr("href")
    if (page_counter < 30) {
      scraper(starting_url = next_url, count = page_counter)
    }
  }
}

# Execute the final function one last time.
scraper(starting_url="https://www.state.gov/press-releases/", count=0)