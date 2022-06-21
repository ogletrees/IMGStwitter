IMGS2022 Twitter
================

A look at twitter use at the 2022 IMGS conference.

The top 11 users (since imgs2022 is in there too)

``` r
# users and number of tweets
df_users <- df %>% count(user_username) %>% arrange(desc(n))
df_users %>% slice(1:11) %>% rename(`Twitter Username` = user_username, `Number of tweets` = n) %>% knitr::kable()
```

| Twitter Username | Number of tweets |
|:-----------------|-----------------:|
| imgs2022         |              113 |
| steph_coen       |               37 |
| RoyalChukz       |               21 |
| ampaimelody      |               16 |
| hobbs_PA         |               12 |
| JoreintjeM       |               11 |
| DrGrantAitken    |                9 |
| jamie0pearce     |                9 |
| gicycle\_        |                7 |
| JennaPanter      |                7 |
| MichaelJWidener  |                7 |
