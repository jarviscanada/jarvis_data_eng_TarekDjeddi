# Introduction
An online store that sells gift-ware called London Gift Shop (LGS) which is located in Uk and been running for more than 10 years. The majority of the customers are wholesalers. The Chief Technology Officer (CTO) of LGS contacted Jarvis consulting software and data engineering services in order to deliver a Proof Of Concept (POC) by visulaizing and analying their data to understand their customers behaviour, which will help LGS marketing team to make decisions in the hope of improving the performance with LGS and gain more profit since their revune did not grow in the past last years. LGS data is stored in a PostgreSQL database which is provisioned using a docker container, and then it is connected to the Jupyter Notebook to answer all the business questions. 
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
The LGS IT team shared a SQL file containing the transaction data between 01/12/2009 and 09/12/2011 with jarvis team since they are not allowed to work in the LGS Azure environment. The diagram bellow is provided by LGS IT team. The architecture of this project consists of two parts: the LGS Azure environment part, and the Jarvis consulting data analytics part. The LGS Azure environment part, is the web application containing the front-end and backend APIs. In the front-end, There is a Content Delivery Network (CDN) which is referred to a geographically distributed group of servers which work together to provide fast delivery of Internet content. A CDN allows for the quick transfer of assets needed for loading Internet content including HTML pages, javascript files, images, and videos (As illustrated in the diagram). The backend API is used to store transactional data in Azure SQL Server, it consists of a bunch of microservices done in Springboot or other web applications. The web application is running inside containers which are managed by Kubernetes. After that, the transactional data (OLTP) were transfered to jarvis's PostgreSQL data warehouse OLAP by performing Extract, Transform, Load (ETL). Finally, connecting Jupyter Notebook to the data warehouse to get access to the data and start visulaizating and analyzing LGS data.  
<br/> <br/>
![Python_data_diagram]([https://user-images.githubusercontent.com/97988554/174128383-62f57c5c-c349-4a69-b564-fba36081f6dc.jpg](https://github.com/jarviscanada/jarvis_data_eng_TarekDjeddi/blob/develop/python_data_analytics/python_data_wrangling/retail_data_analytics_wrangling.ipynb)
## Data Analytics and Wrangling
[Link for the visualization and analyzation code on LGS data](./python_data_analytics/python_data_wrangling/retail_data_analytics_wrangling.ipynb)

### Propositions for Marketing Strategy:
* The LGS marketing team should reach out to can't lose group, which are customers who have not made a purchase recently but when they do, they make many purchases. LGS team may want to give a discount and gift campaign, make recommendations based on their previous activity (purchased and viewed items), and try to contact them and see which products that had bad experince and explain to what you will to fix that. These customers would appriciate that the store is listening to their complains and trying to solve them.
* They might also focus on At risk, and Promising Segments. By giving them discounts since they made recent purchases and they are interested in the products and motivating them to make more purchases. These two segments can increase the revenue dramatically of the store. Also, without forgeting about Loyal and Champions Segments, which are very essential for the revenue of the store.

# Improvements
* We could explore top countries and products in terms of sales and focus more on them or investigate why customers in some countries are not attracted to LGS products.
* We could create a machine learning model like ARIMA or Recurrent Neural Networks (RNN) to forcast the sales.
* We could use Natural language processing (NLP) technique which wil help us for analyzinf customer reviews on products.
