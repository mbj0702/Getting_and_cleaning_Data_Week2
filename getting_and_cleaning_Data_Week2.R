library(jsonlite)
library(httpuv)
library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("Getting_and_Cleaning_Data_Week2",
                   key = "3122154d18b9c40ba4df",
                   secret = "7150563a1554784f278e39462bae5c8b5626ceeb"
)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)

req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

stop_for_status(req)

js = content(req)       # stores the request content

df_git = jsonlite::fromJSON(jsonlite::toJSON(js))       # changes to data.frame

df_git[df_git$full_name == "jtleek/datasharing", "created_at"] # takes the subset of data.frame

