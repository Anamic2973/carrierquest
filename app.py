# from flask import Flask, request, jsonify
# from flask_cors import CORS
# import pandas as pd
# from collections import defaultdict
# import os
# import logging

# logging.basicConfig(level=logging.DEBUG)
# logger = logging.getLogger(__name__)

# app = Flask(__name__)
# CORS(app)

# df = None
# all_tags = []
# profession_vectors = {}
# profession_details = {}

# def load_data():
#     """Load and process the CSV data including job descriptions and skills"""
#     global df, all_tags, profession_vectors, profession_details
    
#     try:
#         base_dir = os.path.dirname(os.path.abspath(__file__))
#         csv_path = os.path.join(base_dir, "tetsing", "assets", "images", "careerquest_1000_professions_with_skills.csv")
        
#         logger.debug(f"Loading CSV from: {csv_path}")
#         df = pd.read_csv(csv_path)
#         logger.info(f"Loaded CSV with {len(df)} rows")
        
#         # Process tags for each row
#         df['Tags'] = df.apply(preprocess_tags, axis=1)
        
#         # Create unique tags list
#         tag_set = set()
#         for tags in df['Tags']:
#             tag_set.update(tags)
#         all_tags = list(tag_set)
        
#         # Create profession vectors and store detailed information
#         for idx, row in df.iterrows():
#             profession = f"{row['Field']}, {row['Profession']}"
            
#             # Create tag vector based on the unique list of tags
#             profession_vectors[profession] = [1 if tag in row['Tags'] else 0 for tag in all_tags]
            
#             # Updated: Use correct CSV column name for future growth potential
#             raw_scope = row.get("Future Growth Potential", "N/A")
#             try:
#                 future_scope_int = int(raw_scope)
#                 future_scope_text = f"{future_scope_int} years in demand"
#             except (ValueError, TypeError):
#                 future_scope_text = str(raw_scope)
            
#             # Updated: Use correct CSV column name for job description
#             job_description = row.get("Job Description", "").strip()
#             if not job_description:
#                 job_description = f"Professional in {row['Field']} specializing in {row['Profession']}"
            
#             skills = row.get("Associated Skills", "")
#             if isinstance(skills, str):
#                 skills = [s.strip() for s in skills.split(',') if s.strip()]
#             else:
#                 skills = []
            
#             # Updated: Use correct CSV column name for education requirement
#             profession_details[profession] = {
#                 "future_scope_years": future_scope_text,
#                 "information": job_description,
#                 "associated_skills": skills,
#                 "field": row['Field'],
#                 "education_required": row.get("Education Requirement", "Not specified"),
#                 "average_salary": row.get("Average Salary", "Not specified")
#             }
            
#         return True
        
#     except Exception as e:
#         logger.error(f"Error loading data: {str(e)}")
#         return False

# def preprocess_tags(row):
#     """Process tags for a single row"""
#     tags = []
#     try:
#         if isinstance(row.get("Personality"), str):
#             tags.extend(row["Personality"].split(","))
#         if isinstance(row.get("Type of Interest"), str):
#             tags.extend(row["Type of Interest"].replace(", ", ",").split(","))
#         if isinstance(row.get("Associated Skills"), str):
#             tags.extend(row["Associated Skills"].split(", "))
#     except AttributeError as e:
#         logger.error(f"Error processing row: {row}")
#         return []
#     return [tag.strip() for tag in tags if tag.strip()]

# @app.route('/recommend', methods=['POST'])
# def recommend():
#     global df, all_tags, profession_vectors, profession_details
    
#     logger.debug("Received recommendation request")
    
#     if df is None or df.empty:
#         logger.warning("No data loaded, attempting to load...")
#         if not load_data():
#             logger.error("Failed to load data")
#             return jsonify([])
    
#     try:
#         data = request.get_json()
#         logger.debug(f"Received data: {data}")
        
#         if not data or 'questions' not in data:
#             logger.warning("No questions provided")
#             return jsonify([])
        
#         selected_questions = data['questions']
#         logger.debug(f"Selected questions: {selected_questions}")
        
#         # Map selected questions to tags.
#         # NOTE: Ensure that `question_mapping` is defined elsewhere in your code.
#         user_tags = []
#         for question in selected_questions:
#             user_tags.extend(question_mapping.get(question, []))
        
#         logger.debug(f"User tags: {user_tags}")
        
#         # Create user vector based on the global list of tags
#         user_vector = [1 if tag in user_tags else 0 for tag in all_tags]
        
#         # Calculate matching scores
#         scores = defaultdict(int)
#         for profession, vector in profession_vectors.items():
#             score = sum(uv * pv for uv, pv in zip(user_vector, vector))
#             scores[profession] = score
        
#         # Get top 3 recommendations that have a positive score
#         top_professions = sorted(
#             [(prof, score) for prof, score in scores.items() if score > 0],
#             key=lambda x: x[1],
#             reverse=True
#         )[:3]
        
#         # Build detailed recommendations to send to the client
#         recommendations = []
#         for prof, score in top_professions:
#             details = profession_details[prof]
#             recommendations.append({
#                 "profession": prof,
#                 "score": score,
#                 "future_scope_years": details["future_scope_years"],
#                 "information": details["information"],
#                 "associated_skills": details["associated_skills"],
#                 "field": details["field"],
#                 "education_required": details["education_required"],
#                 "average_salary": details["average_salary"]
#             })
        
#         logger.debug(f"Sending recommendations: {recommendations}")
#         return jsonify(recommendations)
        
#     except Exception as e:
#         logger.error(f"Error processing request: {str(e)}")
#         return jsonify([])




# # Question mapping remains the same

# # Question mapping remains the same
# question_mapping = {
#     "Do you enjoy working with data and analyzing information?": ["Investigative", "Statistics", "Data Analysis", "Python", "SQL"],
#     "Are you interested in building or designing things?": ["Realistic", "Design", "Architecture", "Engineering"],
#     "Do you like solving complex problems or puzzles?": ["Problem-Solving", "Critical Thinking", "Analytical"],
#     "Are you passionate about artificial intelligence and machine learning?": ["AI Algorithms", "Machine Learning", "Deep Learning", "TensorFlow"],
#     "Do you enjoy protecting systems from cyber threats?": ["Cybersecurity", "Network Security", "Ethical Hacking", "Risk Management"],
#     "Are you interested in medical surgery and patient care?": ["Neurosurgery", "Patient Care", "Healthcare", "Medical"],
#     "Do you want to work in criminal investigations?": ["Forensic", "Criminal Investigation", "DNA Analysis", "Chemistry"],
#     "Are you fascinated by space exploration?": ["Space Science", "Astronomy", "Celestial Objects", "Planetary Science"],
#     "Do you enjoy creating video games?": ["Game Development", "Programming", "Creative", "Problem-Solving"],
#     "Are you interested in predicting weather patterns?": ["Meteorology", "Weather Prediction", "Data Analysis", "General Analytical"],
#     "Do you want to design sustainable energy solutions?": ["Renewable Energy", "Sustainability", "Engineering", "Environmental"],
#     "Are you interested in mental performance optimization?": ["Sports Psychology", "Mental Health", "Performance Enhancement", "Communication"],
#     "Do you care about ethical technology development?": ["AI Ethics", "Responsible AI", "Ethical Decision Making", "Critical Thinking"],
#     "Are you interested in biotechnology research?": ["Biotech", "Medical Research", "Lab Skills", "Chemistry"],
#     "Do you enjoy composing music?": ["Music Composition", "Artistic", "Creative", "Sound Design"],
#     "Are you interested in financial markets?": ["Investment Banking", "Finance", "Risk Management", "Strategic Planning"],
#     "Do you want to study marine ecosystems?": ["Marine Biology", "Ecology", "Environmental Science", "Research"],
#     "Are you interested in user experience design?": ["UX Research", "User-Centered Design", "Psychology", "Communication"],
#     "Do you want to build robotic systems?": ["Robotics", "Engineering", "AI Algorithms", "Problem-Solving"],
#     "Are you interested in disease prevention?": ["Epidemiology", "Public Health", "Data Analysis", "Research"],
#     "Do you enjoy urban planning?": ["Architecture", "Urban Design", "Civil Engineering", "Sustainability"],
#     "Are you interested in psychological research?": ["Psychology", "Behavioral Analysis", "Research Methods", "Critical Thinking"],
#     "Do you want to work with advanced AI systems?": ["Machine Learning", "Deep Learning", "AI Algorithms", "Python"],
#     "Are you interested in DNA analysis?": ["Genetics", "DNA Sequencing", "Forensic Science", "Chemistry"],
#     "Do you enjoy optimizing systems efficiency?": ["Process Optimization", "Analytical Skills", "Problem-Solving", "Engineering"]
# }


# if __name__ == '__main__':
#     logger.info("Starting Flask application...")
#     load_data()
#     app.run(debug=True)











from flask import Flask, request, jsonify
from flask_cors import CORS
import pandas as pd
import os
import logging
import numpy as np
from collections import defaultdict

logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

app = Flask(__name__)
CORS(app)

# Global variables
df = None
profession_details = {}
field_weights = {
    'Technical': 1.2,
    'Healthcare': 1.5,
    'Engineering': 1.2,
    'Science': 1.1,
    'Business': 1.4,
    'Creative': 1.3
}

def load_data():
    """Load and process the CSV data"""
    global df, profession_details
    
    try:
        base_dir = os.path.dirname(os.path.abspath(__file__))
        csv_path = os.path.join(base_dir, "tetsing", "assets", "images", "careerquest_1000_updated.csv")
        
        logger.debug(f"Loading CSV from: {csv_path}")
        df = pd.read_csv(csv_path)
        df.dropna(subset=['Field', 'Profession'], inplace=True)
        
        # Process each profession and store details
        for _, row in df.iterrows():
            profession = f"{row['Field']}, {row['Profession']}"
            
            # Process skills
            skills = row.get("Associated Skills", "")
            if isinstance(skills, str):
                skills = [s.strip() for s in skills.split(',') if s.strip()]
            else:
                skills = []
                
            # Process personality traits
            personality = row.get("Personality", "")
            if isinstance(personality, str):
                personality = [p.strip() for p in personality.split(',') if p.strip()]
            else:
                personality = []
                
            # Process interests
            interests = row.get("Type of Interest", "")
            if isinstance(interests, str):
                interests = [i.strip() for i in interests.split(',') if i.strip()]
            else:
                interests = []
            
            # Store profession details
            profession_details[profession] = {
                "future_scope_years": str(row.get("Future Growth Potential", "N/A")),
                "information": row.get("Job Description", "A professional role in " + row['Field']),
                "associated_skills": skills,
                "field": row['Field'],
                "education_required": row.get("Education Requirement", "Bachelor's degree or equivalent"),
                "average_salary": row.get("Average Salary", "Competitive"),
                "personality": personality,
                "interests": interests,
                "keywords": set(skills + personality + interests + [row['Field'], row['Profession']])
            }
        
        logger.info(f"Loaded {len(profession_details)} professions")
        return True
    
    except Exception as e:
        logger.error(f"Error loading data: {str(e)}")
        return False

def calculate_career_matches(selected_questions):
    """Calculate career matches based on selected questions using multiple criteria"""
    try:
        # Initialize user profile based on selected questions
        user_profile = {
            'skills': set(),
            'interests': set(),
            'personality_types': set(),
            'field_preferences': defaultdict(float)
        }
        
        # Process selected questions to build user profile
        for question in selected_questions:
            tags = question_mapping.get(question, [])
            for tag in tags:
                # Add to skills and interests
                user_profile['skills'].add(tag)
                user_profile['interests'].add(tag)
                
                # Update field preferences
                for field, weight in field_weights.items():
                    if tag in category_mapping.get(field, set()):
                        user_profile['field_preferences'][field] += weight

        # Calculate match scores for each profession
        scores = {}
        for profession, details in profession_details.items():
            # 1. Skills Match (25%)
            skills_match = len(user_profile['skills'] & set(details['associated_skills'])) / \
                          (len(details['associated_skills']) or 1)
            
            # 2. Interest Alignment (25%)
            interest_match = len(user_profile['interests'] & set(details['interests'])) / \
                           (len(details['interests']) or 1)
            
            # 3. Field Relevance (25%)
            field_score = user_profile['field_preferences'].get(details['field'], 0) / \
                         (max(user_profile['field_preferences'].values()) or 1)
            
            # 4. Future Prospects (25%)
            growth_potential = {
                'High': 1.0,
                'Medium': 0.7,
                'Low': 0.4
            }.get(details['future_scope_years'], 0.5)
            
            # Calculate weighted final score
            final_score = (
                0.25 * skills_match +
                0.25 * interest_match +
                0.25 * field_score +
                0.25 * growth_potential
            ) * 100  # Convert to percentage
            
            scores[profession] = final_score

        # Get top 3 matches
        top_matches = sorted(scores.items(), key=lambda x: x[1], reverse=True)[:3]
        
        # Prepare detailed recommendations
        recommendations = []
        for profession, score in top_matches:
            details = profession_details[profession]
            recommendations.append({
                'profession': profession,
                'score': int(score),
                'future_scope_years': details['future_scope_years'],
                'information': details['information'],
                'associated_skills': details['associated_skills'],
                'field': details['field'],
                'education_required': details['education_required'],
                'average_salary': details['average_salary'],
                'personality': details['personality'],
                'interests': details['interests']
            })
        
        return recommendations
    except Exception as e:
        logger.error(f"Error calculating matches: {str(e)}")
        return []

@app.route('/recommend', methods=['POST'])
def recommend():
    """Handle recommendation requests"""
    global df, profession_details
    
    logger.debug("Received recommendation request")
    
    if df is None or not profession_details:
        logger.warning("No data loaded, attempting to load...")
        if not load_data():
            logger.error("Failed to load data")
            return jsonify([])
    
    try:
        data = request.get_json()
        logger.debug(f"Received data: {data}")
        
        if not data or 'questions' not in data:
            logger.warning("No questions provided")
            return jsonify([])
        
        selected_questions = data['questions']
        
        # Calculate career matches
        recommendations = calculate_career_matches(selected_questions)
        
        logger.debug(f"Sending recommendations: {recommendations}")
        return jsonify(recommendations)
        
    except Exception as e:
        logger.error(f"Error processing request: {str(e)}")
        return jsonify([])

# Category mapping for better matching
category_mapping = {
    'Technical': {
        'Programming', 'Python', 'SQL', 'Data Analysis', 'Machine Learning',
        'AI', 'Software Development', 'Coding', 'Database'
    },
    'Analytical': {
        'Problem-Solving', 'Critical Thinking', 'Analysis', 'Research',
        'Statistics', 'Mathematical', 'Logical'
    },
    'Creative': {
        'Design', 'Art', 'Innovation', 'Creative', 'Visual', 'Artistic',
        'UX/UI', 'Content Creation'
    },
    'Healthcare': {
        'Medical', 'Patient Care', 'Biology', 'Health', 'Diagnosis',
        'Treatment', 'Clinical'
    },
    'Business': {
        'Management', 'Leadership', 'Strategy', 'Marketing', 'Finance',
        'Entrepreneurship', 'Business Analysis'
    },
    'Engineering': {
        'Engineering', 'Architecture', 'Construction', 'Manufacturing',
        'Mechanical', 'Electrical', 'Civil'
    }
}

# Question mapping dictionary with comprehensive tags
question_mapping = {
    "Do you enjoy working with data and analyzing information?": [
        "Investigative", "Statistics", "Data Analysis", "Python", "SQL"
    ],
    "Are you interested in building or designing things?": [
        "Realistic", "Design", "Architecture", "Engineering"
    ],
    "Do you like solving complex problems or puzzles?": [
        "Problem-Solving", "Analytical", "Critical Thinking"
    ],
    "Are you passionate about artificial intelligence and machine learning?": [
        "AI Algorithms", "Machine Learning", "Deep Learning", "TensorFlow"
    ],
    "Do you enjoy protecting systems from cyber threats?": [
        "Cybersecurity", "Network Security", "Ethical Hacking", "Risk Management"
    ],
    "Are you interested in medical surgery and patient care?": [
        "Neurosurgery", "Patient Care", "Healthcare", "Medical"
    ],
    "Do you want to work in criminal investigations?": [
        "Forensic", "Criminal Investigation", "DNA Analysis", "Chemistry"
    ],
    "Are you fascinated by space exploration?": [
        "Space Science", "Astronomy", "Celestial Objects", "Planetary Science"
    ],
    "Do you enjoy creating video games?": [
        "Game Development", "Programming", "Creative", "Problem-Solving"
    ],
    "Are you interested in predicting weather patterns?": [
        "Meteorology", "Weather Prediction", "Data Analysis", "General Analytical"
    ],
    "Do you want to design sustainable energy solutions?": [
        "Renewable Energy", "Sustainability", "Engineering", "Environmental"
    ],
    "Are you interested in mental performance optimization?": [
        "Sports Psychology", "Mental Health", "Performance Enhancement", "Communication"
    ],
    "Do you care about ethical technology development?": [
        "AI Ethics", "Responsible AI", "Ethical Decision Making", "Critical Thinking"
    ],
    "Are you interested in biotechnology research?": [
        "Biotech", "Medical Research", "Lab Skills", "Chemistry"
    ],
    "Do you enjoy composing music?": [
        "Music Composition", "Artistic", "Creative", "Sound Design"
    ],
    "Are you interested in financial markets?": [
        "Investment Banking", "Finance", "Risk Management", "Strategic Planning"
    ],
    "Do you want to study marine ecosystems?": [
        "Marine Biology", "Ecology", "Environmental Science", "Research"
    ],
    "Are you interested in user experience design?": [
        "UX Research", "User-Centered Design", "Psychology", "Communication"
    ],
    "Do you want to build robotic systems?": [
        "Robotics", "Engineering", "AI Algorithms", "Problem-Solving"
    ],
    "Are you interested in disease prevention?": [
        "Epidemiology", "Public Health", "Data Analysis", "Research"
    ],
    "Do you enjoy urban planning?": [
        "Architecture", "Urban Design", "Civil Engineering", "Sustainability"
    ],
    "Are you interested in psychological research?": [
        "Psychology", "Behavioral Analysis", "Research Methods", "Critical Thinking"
    ],
    "Do you want to work with advanced AI systems?": [
        "Machine Learning", "Deep Learning", "AI Algorithms", "Python"
    ],
    "Are you interested in DNA analysis?": [
        "Genetics", "DNA Sequencing", "Forensic Science", "Chemistry"
    ],
    "Do you enjoy optimizing systems efficiency?": [
        "Process Optimization", "Analytical Skills", "Problem-Solving", "Engineering"
    ]
}


if __name__ == '__main__':
    logger.info("Starting Flask application...")
    load_data()
    app.run(debug=True)