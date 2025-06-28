import streamlit as st
import pandas as pd
import altair as alt
from snowflake.snowpark import Session

# Connect to Snowflake (auto-managed in Snowflake Streamlit environment)
session = Session.builder.getOrCreate()

st.title("📱 Flipkart Mobile Sales Dashboard")

# Load data from Snowflake table
df = session.table("clean_mobile_sales").to_pandas()

# KPIs
st.metric("Total Products", len(df))
st.metric("Average Selling Price", f"₹{df['SELLING_PRICE'].mean():,.2f}")

# Bar chart: Count by Brand
brand_counts = df['BRAND'].value_counts().reset_index()
brand_counts.columns = ['Brand', 'Count']

bar_chart = alt.Chart(brand_counts).mark_bar().encode(
    x='Brand',
    y='Count',
    tooltip=['Brand', 'Count']
).properties(title="Products Count by Brand")

st.altair_chart(bar_chart, use_container_width=True)

# Rating Distribution histogram
rating_hist = alt.Chart(df).mark_bar().encode(
    x=alt.X('RATING', bin=alt.Bin(maxbins=10)),
    y='count()'
).properties(title="Rating Distribution")

st.altair_chart(rating_hist, use_container_width=True)
