 
## Overview 
- git --> Create a feature branch first
- build dbt models 
    - sources, src
    - staging, stg
    - intermediate, int
    - fact, fct
    - dimension, dim
- dbt run --> Run DBT Models 
- dbt test 
  - generic test 
  - singular test 
- dbt doc generate (optional)
- dbt build 
- deploy 
  - clone git 
  - create profile on big query 
  - dbt deps 
  - dbt build 


## models/  
**Common Functions**

```sql

-- Reference another model
SELECT * FROM {{ ref('stg_jaffle_shop_orders') }}

-- Configure the materialization type
{{
    config(
        materialized = 'view'
    )
}}

-- Reference a source table
SELECT * FROM {{ source('source_name', 'object_name') }}
```

**Common commands**

```bash

# DBT RUN - to run the model, create, config, update table/views
dbt run 
dbt run --full-refresh
dbt run --select dim_customers
dbt run -s staging  'run all the tables under staging folders'

# DBT SOURCE
dbt source freshness

# DBT TEST
dbt test                                'run all tests'
dbt test --select test_type:generic     'run only generic tests'
dbt test --select test_type:singular    'run only singular tests'
dbt test --select [table name]
dbt test --select source:[source name]

# DBT DOCS
dbt docs generate 

```
 
## test/
**1. Source Test** 
- build with source yaml file together 
  
**2. Generic Test** 

generally build within the table under modle directory
- unique - primary key
- not_null - primary key
- relationships 
- accepted_values 

**3. Singular Test**
generally build within TEST directory
 
```sql 

-- e.g. business logic test that payments should positive
with payments as (
    select * 
    from {{ ref('stg_stripe_payments') }}
)

select
    order_id,
    sum(amount) as total_amount
from payments
group by 1
having total_amount < 0 

```

## ANALYSES 

## MACROS 

## SEEDS 

## SNAPSHOTS 


| **Command**       | **Function**                                                                                           |
|--------------------|-------------------------------------------------------------------------------------------------------|
| `dbt run`         | Executes all models (`SELECT` queries) and creates or updates tables, views, or incremental datasets based on the `materialized` configuration. |
| `dbt build`       | Combines `run`, `test`, and `snapshot` into one command, providing an all-in-one build process (recommended). |
| `dbt test`        | Runs tests to validate data quality or enforce constraints (e.g., uniqueness, non-null values).         |
| `dbt seed`        | Loads CSV files into the database as seed data.                                                        |
| `dbt compile`     | Compiles dbt SQL files into raw SQL queries in the `target` folder without executing them.              |
| `dbt debug`       | Checks if the dbt environment is set up correctly, including database connections and configuration files. |
| `dbt docs`        | Generates and allows you to browse project documentation, including lineage graphs and model details.   |





