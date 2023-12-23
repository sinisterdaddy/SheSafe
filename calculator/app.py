from flask import Flask, request, jsonify
import requests

app=Flask(__name__)

@app.route('/verifyAadhaar',methods=['POST'])
def verifyAadhaar():
    try:
        data = request.get_json()

        aadhar_number = data.get('aadhar_number')
        if not aadhar_number:
            return jsonify({"error": "Aadhar number is required"}), 400

        url = "https://verifyaadhaarnumber.p.rapidapi.com/Uidverifywebsvcv1/VerifyAadhaarNumber"

        payload = {
            "txn_id": "17c6fa41-778f-49c1-a80a-cfaf7fae2fb8",
            "consent": "Y",
            "uidnumber": aadhar_number,
            "clientid": "222",
            "method": "uidvalidatev2"
        }

        headers = {
            "content-type": "application/x-www-form-urlencoded",
            "X-RapidAPI-Key": "7118519b77mshc922362ec1c280bp1facc7jsn416669b3f0d1",
            "X-RapidAPI-Host": "verifyaadhaarnumber.p.rapidapi.com"
        }

        response = requests.post(url, data=payload, headers=headers)
        data = response.json()

        if 'Succeeded' in data:
            uid_details = data['Succeeded']['Uid_Details']
            gender = uid_details['Data']['gender']
            return jsonify({"gender": gender})
        else:
            return jsonify({"error": data}), 400

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__=='__main__':
    app.run(debug=True,host="0.0.0.0")