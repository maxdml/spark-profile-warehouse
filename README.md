# spark-profile-warehouse
A profile database for Apache Spark applications

## Description
We aim to build a database of Spark applications' profiles. We store metrics related to application execution (containers metrics, application metrics) which can be related with OS time series (cpu, memory, etc), as well as applications' DAG.
The database exposes an API which allows users to:
• Get information about application behavior
• Build complex performance statistics
• Find subsets of similar application, based on custom similarity factors (e.g. equivalent running time, equivalent errors, equivalent memory consumption, equivalent DAG, etc).
The database will be filled once applications have been executed.

In addition we propose a modification to Spark which allows user to create a DAG without submitting the actual application. That DAG can later be used to query the profile warehouse. An initial implementation is available on @bptschaen [Spark's fork](https://github.com/bptschaen/spark).

An more formal description of the project is available [here]()

## Architecture
The warehouse is made of a SQL database, a rest API which provides access to the data, and a collection engine which wrap Apache Spark application submission, and fill the database once applications are completed (or did fail).

Documentation for the API can be found [here]()
