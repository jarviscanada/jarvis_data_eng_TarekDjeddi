
f contents
* [Introduction](#Introduction)
* [Hadoop Cluster](#Hadoop_Cluster)
* [Hive Project](#Hive_Project)
* [Improvements](#Improvements)
# Introduction
After the succsseful completion of the Python Data Analytics project. Nowadays, data is increasing tremendously every day and storing big data (from gigabytes to petabytes) with
the traditional storage techniques (on one machine) became inficient. In this project, we were working with World Development Indicators (WDI) dataset which containts
around 21 milion data points. At Jarvis, Apache Hadoop is used in order to process and analyize the dataset by using several machines to store the dataset. We 
evaluated Core Hadoop components, including MapReduce, HDFS, and YARN. We created three node Hadoop clusters (one master and two worker nodes), which are provisioned by 
Google Cloud Platform (GCP) DataProc service. Apache Hive and Zeppelin Notebook were used to solve some businiess problems and analize the data using HiveQL queries.
</br> </br>
Technologies been used in this project:
* Google Cloud Platform DataProc
* Zeppelin Notebook
* HiveQL
* Git & Github
# Hadoop Cluster
## Cluster Architecture Diagram
![Hadoop](https://user-images.githubusercontent.com/97988554/177844062-02565d57-09c6-44e7-ae68-21c6946abcd6.png)

## Evaluation of Big Data Tools
### MapReduce
MapReduce is a Hadoop framework used for writing applications that can process vast amounts of data on large clusters. It can also be called a programming model in which we can process large datasets across computer clusters. This application allows data to be stored in a distributed form. It simplifies enormous volumes of data and large scale computing. The MapReduce program is executed in three main phases: mapping, shuffling, and reducing.

* **Mapping Phase**: This is the first phase of the program. There are two steps in this phase: splitting and mapping. A dataset is split into equal units called chunks (input splits) in the splitting step. Hadoop consists of a RecordReader that uses TextInputFormat to transform input splits into key-value pairs. The key-value pairs are then used as inputs in the mapping step. This is the only data format that a mapper can read or understand. The mapping step contains a coding logic that is applied to these data blocks. In this step, the mapper processes the key-value pairs and produces an output of the same form (key-value pairs).

* **Shuffling phase**: This is the second phase that takes place after the completion of the Mapping phase. It consists of two main steps: sorting and merging. In the sorting step, the key-value pairs are sorted using the keys. Merging ensures that key-value pairs are combined. The shuffling phase facilitates the removal of duplicate values and the grouping of values. Different values with similar keys are grouped. The output of this phase will be keys and values, just like in the Mapping phase.

* **Reducer phase**: The output of the shuffling phase is used as the input. The reducer processes this input further to reduce the intermediate values into smaller values. It provides a summary of the entire dataset. The output from this phase is stored in the HDFS.

### Yet Another Resource Negotiator (YARN)
YARN is responsible for allocating system resources to the various applications running in a Hadoop cluster and scheduling tasks to be executed on different cluster nodes. YARN helps to open up Hadoop by allowing to process and run data for batch processing, stream processing, interactive processing, and graph processing which are stored in HDFS. There are three main components of YARN: ResourceManager, NodeManager, and ApplicationMaster.

* **ResourceManager**: It communicates with the NodeManager to keep an inventory of cluster-wide resources. It manages the availability and allocation of the resources thus gaining the main authority in managing the resources. 
* **NodeManager**: It acts as the server for job history. It is responsible for securing information about the completed jobs. It also keeps track of the user's jobs along with their workflow for a particular node.
* **ApplicationMaster**: It is responsible for negotiating resources from the ResourceManager and working with the NodeManager(s) to execute and monitor the containers and their resource consumption.

### Hadoop Distributed File System (HDFS)
HDFS is a distributed file system that handles large data sets running on commodity hardware. It is used to scale a single Apache Hadoop cluster to hundreds and even thousands of nodes. HDFS is one of the major components of Apache Hadoop. HDFS consists of two core components: Name node and Data Node.

* **Name Node**: It's the master node in HDFS that manages the file system metadata. It keeps the directory tree of all files in the file system, and tracks where across the cluster the file data is kept. It does not store the data of these files itself. NameNode controls and manages a single or multiple data nodes.
* **Data Node**: It stores the business data, creating, replicating, deleting, retrieving data blocks as per the instructions of Master (NameNode).

### Apache Hive
Apache Hive is a distributed, fault-tolerant data warehouse system that enables analytics at a massive scale. A data warehouse provides a central store of information that can easily be analyzed to make informed, data driven decisions. Hive allows users to read, write, and manage petabytes of data using SQL.

Hive is built on top of Apache Hadoop, which is an open-source framework used to efficiently store and process large datasets. As a result, Hive is closely integrated with Hadoop, and is designed to work quickly on petabytes of data. What makes Hive unique is the ability to query large datasets, leveraging Apache Tez or MapReduce, with a SQL-like interface.

### Zeppelin
Apache Zeppelin is a new and incubating multi-purposed web-based notebook which brings data ingestion, data exploration, visualization, sharing and collaboration features to Hadoop and Spark.

## Hardware Specifications
* Master Node with 12GB memory and 100GB disk size.
* 2 Worker Nodes, each with 12GB memory and 100GB disk size.

# Hive Project
### Query Optimization
HiveQL queries were optimized using Hive partition and Columnar File Optimization:
* **Hive Partition**: We created `wdi_opencsv_text_partitions` table which partitioned by `year` (57 partitions in total). It improves the performance for queries that involve year attribute.
* **Columnar File Optimization**: We created a table named `wdi_csv_parquet` and stored as PARQUET which stores data in columns instead of rows. It allows us to speed up the time it takes to retrive data from columns.
### Zeppelin Notebook screenshot
![Hive-Project](https://user-images.githubusercontent.com/97988554/177844103-9180eef6-d5b1-4f33-9ab0-5729a23df9f5.png)

# Improvements
* Adding some problems where we need to perform join query and optimize it using buckets.
* Adding more worker nodes and nodes with different specefications to see how it would affect the performance.

