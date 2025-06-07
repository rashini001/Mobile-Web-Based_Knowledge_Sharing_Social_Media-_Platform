# pip install scikit-learn==1.3.2
# pip install numpy
# pip install flask


# load packages==============================================================
from flask import Flask, render_template, request, redirect, url_for
import pickle
import numpy as np
import logging

app = Flask(__name__, static_url_path='/static', static_folder='static')

# Set up logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

# Load the scaler, model, and class names
try:
    scaler = pickle.load(open("prediction/models/scaler.pkl", 'rb'))
    model = pickle.load(open("prediction/models/model.pkl", 'rb'))
    class_names = ['Lawyer', 'Doctor', 'Government Officer', 'Artist', 'Unknown',
                   'Software Engineer', 'Teacher', 'Business Owner', 'Scientist',
                   'Banker', 'Writer', 'Accountant', 'Designer',
                   'Construction Engineer', 'Game Developer', 'Stock Investor',
                   'Real Estate Developer']
except Exception as e:
    print(f"Error loading models: {e}")

def Recommendations(gender, part_time_job, absence_days, extracurricular_activities,
                    weekly_self_study_hours, math_score, history_score, physics_score,
                    chemistry_score, biology_score, english_score, geography_score,
                    total_score, average_score):
    try:
        # Encode categorical variables
        gender_encoded = 1 if gender.lower() == 'female' else 0
        part_time_job_encoded = 1 if part_time_job else 0
        extracurricular_activities_encoded = 1 if extracurricular_activities else 0

        # Create feature array
        feature_array = np.array([[gender_encoded, part_time_job_encoded, absence_days, 
                                 extracurricular_activities_encoded, weekly_self_study_hours,
                                 math_score, history_score, physics_score, chemistry_score,
                                 biology_score, english_score, geography_score,
                                 total_score, average_score]])

        # Scale features
        scaled_features = scaler.transform(feature_array)

        # Predict using the model
        probabilities = model.predict_proba(scaled_features)

        # Get top three predicted classes along with their probabilities
        top_classes_idx = np.argsort(-probabilities[0])[:3]
        recommendations = [(class_names[idx], round(probabilities[0][idx] * 100, 2)) 
                         for idx in top_classes_idx]

        return recommendations

    except Exception as e:
        print(f"Error in prediction: {e}")
        return []

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/recommend')
def recommend():
    return render_template('recommend.html')

@app.route('/pred', methods=['GET', 'POST'])
def pred():
    logger.debug(f"Method: {request.method}")
    if request.method == 'POST':
        try:
            logger.debug(f"Form data: {request.form}")
            # Get form data
            gender = request.form['gender']
            part_time_job = request.form['part_time_job'] == 'true'
            absence_days = int(request.form['absence_days'])
            extracurricular_activities = request.form['extracurricular_activities'] == 'true'
            weekly_self_study_hours = int(request.form['weekly_self_study_hours'])
            
            # Get scores
            math_score = int(request.form['math_score'])
            history_score = int(request.form['history_score'])
            physics_score = int(request.form['physics_score'])
            chemistry_score = int(request.form['chemistry_score'])
            biology_score = int(request.form['biology_score'])
            english_score = int(request.form['english_score'])
            geography_score = int(request.form['geography_score'])
            
            # Calculate total and average scores
            total_score = (math_score + history_score + physics_score + 
                         chemistry_score + biology_score + english_score + 
                         geography_score)
            average_score = total_score / 7.0

            # Get recommendations
            recommendations = Recommendations(
                gender, part_time_job, absence_days, extracurricular_activities,
                weekly_self_study_hours, math_score, history_score, physics_score,
                chemistry_score, biology_score, english_score, geography_score,
                total_score, average_score
            )

            return render_template('results.html', 
                                 recommendations=recommendations,
                                 total_score=total_score,
                                 average_score=round(average_score, 2))

        except Exception as e:
            logger.error(f"Error in prediction: {str(e)}")
            return render_template('error.html', error=str(e))
    else:
        return redirect(url_for('recommend'))

if __name__ == '__main__':
    app.debug = True
    app.run(host='localhost', port=5000)  # Specify host and port explicitly