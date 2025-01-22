# PhygitalDWH

## Overview

This repository contains scripts for managing a data warehouse using ETL (Extract, Transform, Load) processes, filling an operational database, and handling metadata. The scripts are primarily written in Python and are designed to integrate with Google Cloud and Tableau for data visualization.

## Features

- **ETL Processes**: Efficiently extract, transform, and load data from various sources.
- **Operational Database Filling**: Populate and maintain the operational database with clean and structured data.
- **Metadata Management**: Handle and store metadata using GraphQL.
- **Google Cloud Integration**: Scripts designed to work with Google Cloud Platform.
- **Tableau Integration**: Seamlessly connect with Tableau for creating interactive data visualizations and dashboards.

## Directory Structure

```
.
├── DB_scripts/
│   ├── alter.sql
│   ├── createDB-2.sql
│   ├── fillDB-2.sql
│   ├── phygital_dwh_backup.sql
│   └── postgres_dwh.sql
├── ETL/
│   ├── myenv/
│   ├── python_fill_data/
│   ├── config.py
│   ├── convertdwhtosql.py
│   ├── create_tables.sql
│   ├── dimDay.py
│   ├── dimFlow.py
│   ├── dimLocation.py
│   ├── dump.sql
│   ├── dwh_tools.py
│   ├── factUserEngagement.py
│   ├── insert_data.sql
│   ├── insertino.py
│   ├── main.py
│   ├── phygital_dwh_backup.sql
│   └── requirements.txt
├── Metadata/
│   ├── .gitkeep
│   ├── graphql.graphql
│   └── integration4.json
├── .gitignore
├── README.md
├── docker-compose.yml
├── phygital_dwh_backup.sql
└── postgreserver.sh
```

### DB_scripts

Scripts for creating and populating the database schema.

- `alter.sql`: SQL script for altering the database schema.
- `createDB-2.sql`: SQL script for creating the database.
- `fillDB-2.sql`: SQL script for filling the database with data.
- `phygital_dwh_backup.sql`: Backup of the data warehouse.
- `postgres_dwh.sql`: SQL script for setting up PostgreSQL data warehouse on GCP.

### ETL

Contains ETL scripts for extracting, transforming, and loading data.

- `myenv/`: Directory for environment configurations.
- `python_fill_data/`: Directory for Python scripts to fill data.
- `config.py`: Configuration file for ETL scripts.
- `convertdwhtosql.py`: Script to convert DWH data to SQL.
- `create_tables.sql`: SQL script for creating tables.
- `dimDay.py`: Script to handle `dimDay` dimension.
- `dimFlow.py`: Script to handle `dimFlow` dimension.
- `dimLocation.py`: Script to handle `dimLocation` dimension.
- `dump.sql`: SQL dump file.
- `dwh_tools.py`: Tools and utilities for data warehouse.
- `factUserEngagement.py`: Script to handle `factUserEngagement`.
- `insert_data.sql`: Script for inserting data.
- `insertino.py`: Python script for inserting data into GCP database.
- `main.py`: Main script for ETL process.
- `phygital_dwh_backup.sql`: Backup of the data warehouse.
- `requirements.txt`: Python dependencies for the project.

### Metadata

Scripts and files for metadata management.

- `.gitkeep`: Placeholder to keep the directory in version control.
- `graphql.graphql`: GraphQL script for creating metadata.
- `integration4.json`: JSON file for metadata.

## Getting Started

### Prerequisites

- Python 3.x
- PostgreSQL or MySQL (Operational Database)
- Google Cloud Platform (GCP) account
- Tableau Desktop/Server

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/wk8481/PhygitalDWH.git
   cd PhygitalDWH
   ```

2. Install the required Python packages:
   ```bash
   pip install -r ETL/requirements.txt
   ```

### Usage

1. **Running ETL Scripts**:
   - Navigate to the `ETL` directory and run the desired ETL script:
     ```bash
     cd ETL
     python main.py
     ```

2. **Populating Operational Database**:
   - Navigate to the `DB_scripts` directory and run the schema and data scripts:
     ```bash
     cd DB_scripts
     psql -f createDB-2.sql
     psql -f fillDB-2.sql
     ```

3. **Metadata Management**:
   - Navigate to the `Metadata` directory and run the metadata scripts:
     ```bash
     cd Metadata
     graphql graphql.graphql
     ```

4. **Google Cloud and Tableau Integration**:
   - Follow the instructions in the respective scripts (`insertino.py`, `dwh_tools.py`) to connect and push data to GCP and Tableau.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request with your changes.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

## Contact

For any questions or inquiries, please contact [williamkasasa26@gmail.com](mailto:williamkasasa26@gmail.com).
