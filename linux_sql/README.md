# Linux Cluster Monitoring Agent
# Introduction
This project will allow Jarvis Linux Cluster Administration (LCA) team to track hardware information and recourse usage of each node in real-time, which are running on CentOS 7. This is done by gathering server usage data such as: available memory, disk space, cpu idle, and cpu kernel, ..etc. These information are collected and saved in a PostgreSQL database automatically evey minute in the background. On the other hand, the hardware specifications data like: system hostname, number of CPU, CPU architecture, ... etc. These are assumed to be static, which means that they will be collected once only.
The list of technolgies that been used:
