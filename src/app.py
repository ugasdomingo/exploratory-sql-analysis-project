import os
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
import pandas as pd
import re


# Load environment variables
load_dotenv()

# Read DB path from environment variable
DB_PATH = os.getenv('DB_PATH', './data/database.db')  # fallback to default
DB_URL = f'sqlite:///{DB_PATH}'

# Removes SQL single-line comments (--) from a query string without modifying the original file.
def clean_query(query):
    query = re.sub(r'--.*', '', query)
    query = query.replace('`', '')
    query = query.strip()
    return query

# Connect to the existing SQLite database
def connect():
    try:
        engine = create_engine(DB_URL)
        engine.connect()
        print("✅ Connected to existing SQLite database.")
        return engine
    except Exception as e:
        print(f"❌ Error connecting to database: {e}")
        return None

# Run student-defined queries from queries.sql
def run_queries_from_file(engine, filepath):
    try:
        with open(filepath, 'r') as file:
            content = file.read()
        queries = [q.strip() for q in content.split(';') if q.strip()]
        for i, query in enumerate(queries, start=1):
            query = clean_query(query)

            if not query:
                continue

            try:
                print(f"\n🔎 Query {i}:\n{query}")

                if query.lower().startswith("select"):
                    df = pd.read_sql(query, con=engine)
                    print(df)
                else:
                    with engine.begin() as conn:  # 🔥 importante (auto-commit)
                        conn.execute(text(query))
                        print("✅ Query executed successfully.")
            except Exception as e:
                print(f"❌ Error in Query {i}: {e}")
    except Exception as e:
        print(f"❌ Error processing queries from {filepath}: {e}")


# Entry point
if __name__ == "__main__":
    engine = connect()
    if engine:
        run_queries_from_file(engine, './src/sql/queries.sql')