library(RMariaDB)
library(dplyr,dbplyr)

#method for loading csv file to database>>>
# I created a table 'arxiv' and loaded the csv using command prompt by
# LOAD DATA LOCAL INFILE 'C:/xampp/mysql/data/arxiv_150/arxiv_articles.csv'  INTO TABLE arxiv FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;



connection <- dbConnect(RMariaDB::MariaDB(),
                        dsn = "arxiv-connection",
                        Server = "localhost",
                        dbname = "arxiv_150",
                        user = "root"
)

#shows tables
dbListTables(connection)
# [1] "arxiv"

#shows fields
dbListFields(connection, "arxiv")
#[1] "col"      "Title"    "Author"   "Subject" 
#[5] "Abstract" "Meta"

arxiv_dta <- dbGetQuery(connection, "SELECT * FROM arxiv_150.arxiv")

glimpse(arxiv_dta)

#Rows: 150
#Columns: 6
#$ col      <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,…
#$ Title    <chr> "Seamless Human Motion Composition…
#$ Author   <chr> "German Barquero, Sergio Escalera,…
#$ Subject  <chr> "Computer Vision and Pattern Recog…
#$ Abstract <chr> "Conditional human motion generati…
#$ Meta     <chr> "Fri, 23 Feb 2024 18:59:40 UTC (15…


#selected fields of table
arxiv_sel <- dbGetQuery(connection, "SELECT Title, Abstract FROM arxiv_150.arxiv")
arxiv_sel[c(1,2),]
arxiv_sel[c(4,2),]


#getting all data using SELECT * FROM
sqlQuery <- "SELECT Author, Meta FROM arxiv_150.arxiv"

as_tibble(dbGetQuery(connection, sqlQuery))

# A tibble: 150 × 2
# Author                                       Meta 
# <chr>                                        <chr>
# 1 "German Barquero, Sergio Escalera, Cristina… Fri,…
# 2 "Jianguo Zhang, Tian Lan, Rithesh Murthy, Z… Fri,…
# 3 "Yuejiang Liu, Alexandre Alahi"              Fri,…
# 4 "Chun-Hsiao Yeh, Ta-Ying Cheng, He-Yen Hsie… Fri,…
# 5 "Emanuel Herrendorf, Christian Komusiewicz,… Fri,…
# 6 "Xuyang Li, Hamed Bolandi, Mahdi Masmoudi, … Fri,…
# 7 "Kinjal Basu, Ibrahim Abdelaziz, Subhajit C… Fri,…
# 8 "Abolfazl Younesi, Mohsen Ansari, MohammadA… Fri,…
# 9 "Hanxiao Jiang, Binghao Huang, Ruihai Wu, Z… Fri,…
# 10 "Majid Behbahani, Mina Dalirrooyfard, Elahe… Fri,…
# ℹ 140 more rows
# ℹ Use `print(n = ...)` to see more rows


#inserting a data 
query <- "INSERT INTO arxiv(col, Title, Author, Subject, Abstract, Meta) 
          VALUES ('', 'Database-arxiv', 'Darlene Lapso', 'R-Databases Integration', 
          'Loading and importing csv file using cmd and connect it to database/mysql.', 'March 9, 2023')"

query_result <- dbSendQuery(connection, query)

dbClearResult(query_result)


arxiv_updta <- dbGetQuery(connection, 'SELECT * FROM
                          arxiv_150.arxiv')
tail(arxiv_updta)

#the inserted data has been multipled since I entered it multiple times.:(


arxiv_seeUp <- dbGetQuery(connection, "SELECT Title, Author, Subject, Meta FROM arxiv_150.arxiv")
(arxiv_seeUp <- tail(arxiv_seeUp, n = 5))


#                                                           Title
# 149                      Font Impression Estimation in the Wild
# 150 Multi-Agent Collaboration Framework for Recommender Systems
# 151                                              Database-arxiv
# 152                                              Database-arxiv
# 153                                              Database-arxiv
#                                                          Author
# 149           Kazuki Kitajima, Daichi Haraguchi, Seiichi Uchida
# 150 Zhefan Wang, Yuanqing Yu, Wendi Zheng, Weizhi Ma, Min Zhang
# 151                                               Darlene Lapso
# 152                                               Darlene Lapso
# 153                                               Darlene Lapso
#                                             Subject
# 149 Computer Vision and Pattern Recognition (cs.CV)
# 150                   Information Retrieval (cs.IR)
# 151                         R-Databases Integration
# 152                         R-Databases Integration
# 153                         R-Databases Integration
#                                          Meta
# 149  Fri, 23 Feb 2024 10:00:25 UTC (1,325 KB)
# 150 Fri, 23 Feb 2024 09:57:20 UTC (24,597 KB)
# 151                             March 9, 2023
# 152                             March 9, 2023
# 153                             March 9, 2023


write.csv(arxiv_updta, file = "arxiv_150.csv", row.names = FALSE)

dbDisconnect(connection)
