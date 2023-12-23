from flask import Flask, request, jsonify
import face_recognition

app = Flask(__name__)

def predict_gender(image_path):
    # Load the image using face_recognition library
    image = face_recognition.load_image_file(image_path)
    
    # Detect faces in the image
    face_locations = face_recognition.face_locations(image)
    
    # For simplicity, assume the first detected face as the target face
    if face_locations:
        # You may need to use a gender classification model here for gender prediction
        # For example, you could use a pre-trained model like a neural network
        # This example assumes a simple rule-based system based on face position
        # In practice, use a proper gender classification model
        top, right, bottom, left = face_locations[0]
        face_height = bottom - top
        face_width = right - left
        
        # If the face is wider than taller, predict as male, otherwise as female
        if face_width > face_height:
            return 'Male'
        else:
            return 'Female'
    else:
        return 'No face detected'

@app.route('/predict_gender', methods=['POST'])
def get_gender():
    if request.method == 'POST':
        file = request.files['file']
        if file:
            file_path = 'temp.jpg'  # Save the uploaded image temporarily
            file.save(file_path)
            gender = predict_gender(file_path)
            return jsonify({'gender': gender})
        else:
            return jsonify({'error': 'Invalid input'})
    else:
        return jsonify({'error': 'Invalid request method'})

if __name__ == '__main__':
    app.run(debug=True)
