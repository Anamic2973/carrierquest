import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import LabelEncoder
import joblib

# Create sample data
np.random.seed(42)

# Create sample professions
professions = [
    'Data Scientist',
    'Software Engineer',
    'AI Specialist',
    'Cybersecurity Analyst',
    'Cloud Architect',
    'UX Designer',
    'Product Manager',
    'Business Analyst'
]

# Create sample feature vector size (matching BERT embedding size + other features)
feature_size = 384  # BERT embedding size
feature_size += 16  # MBTI features
feature_size += 6   # RIASEC features
feature_size += 4   # Education levels
feature_size += 3   # Growth potential levels
feature_size += 1   # Salary feature

# Generate sample training data
n_samples = 1000
X = np.random.rand(n_samples, feature_size)
y = np.random.choice(professions, n_samples)

# Create and fit label encoder
label_encoder = LabelEncoder()
y_encoded = label_encoder.fit_transform(y)

# Train a simple model
model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X, y_encoded)

# Save model and label encoder
joblib.dump(model, 'career_recommendation_xgb_bert.pkl')
joblib.dump(label_encoder, 'profession_label_encoder.pkl')

# Create sample CSV data
data = {
    'Profession': y,
    'Personality': [','.join(np.random.choice(['INTJ', 'ENTJ', 'INFJ', 'ENFJ'], 2)) for _ in range(n_samples)],
    'Type of Interest': [','.join(np.random.choice(['Investigative', 'Artistic', 'Social', 'Enterprising'], 2)) for _ in range(n_samples)],
    'Education Requirement': np.random.choice(["Bachelor's", "Master's", "PhD", "High School"], n_samples),
    'Future Growth Potential': np.random.choice(['High', 'Medium', 'Low'], n_samples),
    'Average Salary': np.random.randint(50000, 150000, n_samples)
}

df = pd.DataFrame(data)
df.to_csv('tetsing/assets/images/careerquest_1000_updated.csv', index=False)

print("Files created successfully:")
print("1. career_recommendation_xgb_bert.pkl")
print("2. profession_label_encoder.pkl")
print("3. careerquest_1000_updated.csv")