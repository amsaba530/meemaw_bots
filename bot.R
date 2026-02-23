library(plumber)
library(httr)
library(jsonlite)

BOT_ID <- "e11160588ecb53c6eb29c12276"
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
    if (!is.null(data$sender_id) && data$sender_id != BOT_ID) {
      
      # Check if message contains "puddin"
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