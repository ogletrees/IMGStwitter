# Date: 2022-06-21
# S Ogletree
# Description: IMGS tweetin'

library(tidyverse)
library(academictwitteR)

df <- bind_tweets("../testing/", output_format = "tidy")
# remove dupes
df <- df %>% distinct(tweet_id, .keep_all = T)

range(df$created_at)
# mark retweets vs. not
df <- df %>% mutate(is_retweet = ifelse(grepl("RT", text),  1, 0))

# users and number fo tweets
df_users <- df %>% count(user_username) %>% arrange(desc(n))
df_users

# make a local time tweet
df <- df %>% mutate(local_tw_time = lubridate::with_tz(
  lubridate::ymd_hms(created_at), tzone = "Europe/London"))

df <- df %>% mutate(dow = lubridate::wday(local_tw_time, label = T), day = lubridate::day(local_tw_time))

# tweets per day
tpd <- df  %>% count(day)
tpd %>% ggplot(aes(day, n)) + geom_col()
tpd %>% filter(day > 18)%>% ggplot(aes(day, n)) + geom_col()
df %>% 
  filter(day > 17) %>%
  mutate(dow = fct_relevel(dow, "Sat")) %>% 
  ggplot(aes(dow)) + geom_bar(fill = "darkblue") + labs(title = "#IMGS2022 Tweets", x = "Conference day", y = "number of tweets") + theme_minimal()

# most likes
lks <- df %>% arrange(desc(like_count)) %>% slice(1:20) %>% select(user_username, user_name,text, local_tw_time, like_count)

# when to people tweet
twhrs <- df %>% mutate(twhr = lubridate::hour(local_tw_time))
twhrs %>% ggplot(aes(twhr)) + geom_bar(fill = "steelblue") + labs(title = "Tweets by hour of the day", subtitle = "#IMGS2022", x = "Hour of the day", y = "number of tweets") + theme_minimal()
