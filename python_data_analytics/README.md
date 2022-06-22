# Introduction
An online store that sells gift-ware called London Gift Shop (LGS) located in Uk and been running for more than 10 years. The majority of the customers are wholesalers. The Chief Technology Officer (CTO) of LGS contacted Jarvis consulting software and data engineering services to deliver a Proof Of Concept (POC) project by visualizing and analyzing their data to understand their customer's behavior, which will help the LGS marketing team to make decisions in the hope of improving the performance of LGS and gain more profit since their revenue did not grow in the past last years. LGS data is stored in a PostgreSQL database which is provisioned using a docker container, and then it is connected to the Jupyter Notebook to answer all the business questions.
<br/>
<br/>
Technolgies that been used:

  * PostgreSQL 
  * Jupyter Notebook
  * Pandas & Numpy
  * Data Warehouse
  * Data Analytics
  * Data visulaization

# Implementaion
## Online Store Cloud Architecture
The LGS IT team shared a SQL file containing the transaction data between 01/12/2009 and 09/12/2011 with the Jarvis team since the Jarvis team is not allowed to work in the LGS Azure environment. The diagram below is provided by the LGS IT team. The architecture of this project consists of two parts: the LGS Azure environment part, and the Jarvis consulting data analytics part. The LGS Azure environment part is the web application containing the front-end and backend APIs. In the front-end, There is a Content Delivery Network (CDN) which is referred to as a geographically distributed group of servers that work together to provide fast delivery of Internet content. A CDN allows for the quick transfer of assets needed for loading Internet content including HTML pages, javascript files, images, and videos (As illustrated in the diagram). The backend API is used to store transactional data in Azure SQL Server, it consists of a bunch of microservices done in Springboot or other web applications. The web application is running inside containers which are managed by Kubernetes. After that, the transactional data (OLTP) were transferred to Jarvis's PostgreSQL data warehouse OLAP by performing Extract, Transform, Load (ETL). Finally, connect Jupyter Notebook to the data warehouse to get access to the data and start visualizing and analyzing LGS data. 
<br/> <br/>
![Python_data_diagram](https://user-images.githubusercontent.com/97988554/174166771-fbcc008b-e9e6-440c-bd39-142210b01d11.jpg)

## Data Analytics and Wrangling
[Link for the visualization and analyzation code on LGS data](retail_data_analytics_wrangling.ipynb`)

### Propositions for Marketing Strategy:
* The LGS marketing team should reach out to the can't lose group, which are customers who have not made a purchase recently but when they do, they spend a lot of money. LGS team may want to give a discount and gift campaign, make recommendations based on their previous activity (purchased and viewed items), try to contact them and see which products they had a bad experience with, and explain what you will to fix that. These customers would appreciate that the store is listening to their complaints and trying to solve them.
* They might also focus on At risk, and Promising Segments. By giving them discounts since they made recent purchases and they are interested in the products and motivating them to make more purchases. These two segments can increase the revenue dramatically of the store. Also, without forgetting about Loyal and Champions Segments, which are very essential for the revenue of the store.

# Improvements
* We could explore top countries and products in terms of sales and focus more on them or investigate why customers in some countries are not attracted to LGS products.
* We could create a machine learning model like ARIMA or Recurrent Neural Networks (RNN) to forecast the sales.
* We could use the Natural language processing (NLP) technique which will help us for analyzing customer reviews on products.

