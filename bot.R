library(plumber)
library(httr)
library(jsonlite)

BOT_ID <- "	9fdd45c6996d3ce1cdddf06404"
responses <- c(
  "the proof is in the puddin! 🍮",
  "Did someone say puddin?",
  "PUDDIN ALERT 🚨",
  "I love puddin."
)

#* @post /
function(req, res) {
  
  body <- req$postBody
  
  if (!is.null(body) && body != "") {
    data <- fromJSON(body)
    
    # Only respond to messages from humans (ignore bots)
    if (!is.null(data$sender_type) && data$sender_type != "bot") {
      
      if (!is.null(data$text) && grepl("puddin", tolower(data$text))) {
        
        RESPONSE_TEXT <- sample(responses, 1)
        
        POST(
          url = "https://api.groupme.com/v3/bots/post",
          body = list(
            bot_id = BOT_ID,
            text = RESPONSE_TEXT
          ),
          encode = "json"
        )
      }
    }
  }
  
  res$status <- 200
  return(list(status = "ok"))
}