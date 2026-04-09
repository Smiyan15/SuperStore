import pandas as pd
from sqlalchemy import create_engine
df= pd.read_csv("Sample-Superstore.csv", encoding = 'latin-1')

df = df.drop(columns=['csvbase_row_id'])

df.columns = df.columns.str.strip().str.replace('ï»¿', '')

df.columns = (df.columns
              .str.strip()
              .str.lower()
              .str.replace(' ', '_')
              .str.replace('-', '_'))

# Fix date columns
df['order_date'] = pd.to_datetime(df['order_date'])
df['ship_date'] = pd.to_datetime(df['ship_date'])

# Add calculated columns
df['profit_margin'] = round((df['profit'] / df['sales']) * 100, 2)
df['days_to_ship'] = (df['ship_date'] - df['order_date']).dt.days
df['order_year'] = df['order_date'].dt.year
df['order_month'] = df['order_date'].dt.month
df['order_month_name'] = df['order_date'].dt.strftime('%b')

# Verify
print("Cleaned columns:", df.columns.tolist())
print("\nShape:", df.shape)
print("\nSample:")
print(df[['order_id', 'order_date', 'sales', 'profit',
          'profit_margin', 'days_to_ship', 'order_year']].head())

# Replace YOUR_PASSWORD with your MySQL root password
engine = create_engine('mysql+mysqlconnector://root:admin123@localhost/superstore_db')

df.to_sql('orders', con=engine, if_exists='replace', index=False)
print("Data loaded to MySQL successfully!")