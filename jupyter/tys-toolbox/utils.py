"""All custom utilities in one place"""
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

def quick_summary(df):
    """Get enhanced dataframe summary"""
    print(f"Shape: {df.shape}")
    print(f"Memory: {df.memory_usage().sum() / 1024**2:.2f} MB")
    print(f"\nNull counts:")
    print(df.isnull().sum()[df.isnull().sum() > 0])
    return df.describe()

def plot_distribution(df, column, bins=30):
    """Quick distribution plot"""
    fig, ax = plt.subplots(figsize=(10, 6))
    df[column].hist(bins=bins, ax=ax)
    ax.set_title(f"Distribution of {column}")
    return fig

# Add more utilities as needed
def test():
    print("test")