# Enterprise AI Consumer Complaints Analytics Platform
Python | SQL | Power BI | NLP | RAG | LLM 

## Overview

This project presents an end-to-end Enterprise AI analytics platform designed to analyse consumer complaints, identify complaint trends, generate AI-powered business insights, and support executive decision-making. The solution integrates SQL, Python, Power BI, Natural Language Processing (NLP), Retrieval-Augmented Generation (RAG), and Large Language Models (LLMs) to transform structured and unstructured complaint data into actionable business intelligence.

The project follows the complete analytics lifecycle, including data preprocessing, SQL-based analytics, semantic search, embedding generation, AI-assisted complaint analysis, dashboard development, and interactive reporting. The primary objective is to enable organisations to monitor customer complaints, evaluate operational performance, and leverage AI for intelligent complaint analysis.

---

## Dashboard Preview

<img width="1322" height="741" alt="Screenshot 2026-07-06 024732" src="https://github.com/user-attachments/assets/918213d0-291b-4c53-9eb6-fdca134f88e0" />
 
---

# Dataset Information

The project uses the Consumer Financial Protection Bureau (CFPB) Consumer Complaint Database containing consumer complaints submitted against financial institutions across the United States.

The dataset includes:

* Complaint ID
* Date Received
* Product
* Sub-product
* Issue
* Company
* State
* Consumer Complaint Narrative
* Company Response
* Timely Response
* Consumer Consent
* Submitted Via
* Tags
* ZIP Code

The dataset was initially processed using Python before being analysed in SQL and visualised in Power BI. Consumer narratives were later transformed into embeddings for semantic search and AI-powered retrieval.

---

# Tools & Technologies Used

## Programming & AI

* Python
* Pandas
* NumPy
* Scikit-learn
* Sentence Transformers
* LangChain
* OpenAI API

## Database Technologies

* MySQL
* SQL
* Window Functions
* Views
* Common Table Expressions (CTEs)

## Artificial Intelligence

* Natural Language Processing (NLP)
* Vector Embeddings
* Retrieval-Augmented Generation (RAG)
* Large Language Models (LLMs)
* Semantic Search

## Business Intelligence

* Power BI
* DAX
* Power Query

## Development Tools

* Jupyter Notebook
* Visual Studio Code
* Git
* GitHub

---

# Project Workflow

## 1. Data Collection

The CFPB Consumer Complaint dataset was imported into Python for initial inspection and preprocessing.

---

## 2. Data Cleaning & Preprocessing

Several preprocessing techniques were applied to improve data quality.

* Handling missing values
* Removing duplicate records
* Correcting data types
* Standardising categorical values
* Text preprocessing
* SQL-ready formatting

---

## 3. Exploratory Data Analysis (EDA)

Exploratory analysis was performed to understand complaint behaviour.

The analysis included:

* Complaint volume analysis
* Product-wise complaint analysis
* Company performance analysis
* State-wise complaint distribution
* Timely response analysis
* Complaint trend analysis
* Consumer issue analysis

---

## 4. SQL Analytics

The cleaned dataset was imported into MySQL where advanced SQL queries were developed using:

* Aggregate Functions
* CASE Statements
* GROUP BY
* HAVING
* Joins
* Window Functions
* Views
* Common Table Expressions (CTEs)

---

## 5. AI Pipeline Development

An AI-powered complaint intelligence pipeline was developed using NLP and RAG.

The pipeline performs:

* Text preprocessing
* Embedding generation
* Vector storage
* Semantic complaint retrieval
* LLM-based response generation
* AI business insight generation

---

## 6. Power BI Dashboard Development

An executive Power BI dashboard was developed to monitor complaint performance through interactive visualisations and KPIs.

### Dashboard Features

* Total Complaints KPI
* Total Products KPI
* Total Companies KPI
* Total States KPI
* Timely Response KPI
* Complaint Trend Over Time
* Top 5 Complaint Products
* Top 5 Complaint Issues
* Top 5 Companies by Complaints
* Complaint Distribution by State
* Interactive Filters
* AI Business Insights Panel

---

## 7. AI Business Insights

The dashboard automatically highlights important business findings.

### Key Insights

* Credit Reporting generates the highest complaint volume.
* Experian receives the highest number of complaints.
* 99.59% of complaints received a timely response.
* Texas records the highest complaint volume.
* Complaint volume has increased during the recent reporting period.

---

# How to Run the Project

## Step 1: Clone the Repository

```bash
git clone <repository-link>
```

## Step 2: Install Required Libraries

```bash
pip install pandas numpy scikit-learn sentence-transformers langchain openai streamlit
```

## Step 3: Open Jupyter Notebook

Run:

```
Enterprise_AI_Complaints_Analytics.ipynb
```

## Step 4: Configure MySQL

* Create a MySQL database
* Import the cleaned dataset
* Execute the SQL scripts

## Step 5: Run the AI Pipeline

Generate embeddings and launch the RAG application.

## Step 6: Open Power BI Dashboard

Open:

```
Enterprise_AI_Consumer_Complaints_Dashboard.pbix
```

to explore the interactive dashboard.

---

# Project Files

| File Name | Description |
|------------|-------------|
| complaints_mysql_ready.csv | Cleaned complaint dataset |
| Enterprise_AI_Complaints_Analytics.ipynb | Python preprocessing & AI workflow |
| SQL_Scripts.sql | SQL analytics queries |
| Enterprise_AI_Consumer_Complaints_Dashboard.pbix | Power BI dashboard |
| README.md | Project documentation |

---

# Business Value

This project enables organisations to:

* Improve complaint monitoring and reporting
* Reduce manual complaint analysis effort
* Support executive decision-making
* Identify operational trends and customer issues
* Enable AI-powered semantic search

---

# Future Enhancements

* Real-time complaint streaming
* Azure AI integration
* Microsoft Fabric implementation
* Predictive complaint forecasting
* AI-powered chatbot
* Automated complaint classification

---

# Conclusion

This project demonstrates an end-to-end enterprise analytics solution by integrating SQL, Python, Power BI, NLP, RAG, and Large Language Models into a single intelligent platform. It showcases modern business intelligence, AI-powered analytics, semantic search, executive dashboard development, and data-driven decision-making for enterprise customer complaint management.
