
# -------------------------------------------------------------------------
#
# DESCRIPTION: SUNDAY FUNDAY: FUNCTION INSTRUCTIONS
# DEVELOPER: BEREND
# SOURCE: https://nicercode.github.io/guides/functions/
#
# Sun Jan 05 11:40:29 2020 ------------------------------

# Basic syntax -------------------------------------------------------------------------

sum.of.squares <- function(x,y) {
  x^2 + y^2
}

sum.of.squares(3, 4)

# The Procedure:
# 1. Define the function,
# 2. Load the function into the R session,
# 3. Use the function.


# Define the function -------------------------------------------------------------------------

function.name <- function(arg1, arg2, arg3=2, ...) {
  newVar <- sin(arg1) + sin(arg2)  # do Some Useful Stuff
  newVar / arg3   # return value 
}

# "Ideally functions are short and do just one thing -
# problems are rarely too small to benefit from some abstraction."


# Load the function -------------------------------------------------------------------------
# There are two methods for loading functions into the memory:
# 1. Copy the function text and paste it into the console
# 2. Use the source() function to load your functions from file.
#     > in second case, use source("R/function.R") to read the function


# Some other stuff --------------------------------------------------------
data <- read.csv("C:/Users/Gebruiker/Downloads/seed_root_herbivores.csv")

mean(data$Height)
var(data$Height)
summary(data$Height)
sqrt(var(data$Height)/length(data$Height))


standard.error <- function(x) {
  sqrt(var(x)/length(x))
}

standard.error(data$Height)
