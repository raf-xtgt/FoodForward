import base64
from io import BytesIO
from PIL import Image
import google.generativeai as genai
import os
from flask import Flask, request, jsonify


app = Flask(__name__)
genai.configure(api_key="AIzaSyCnyK16Z8AuD07Lta5sPbRf_vWjKW7Y318")
model = genai.GenerativeModel('gemini-1.5-flash-001')

def decode_base64_image(base64_string):
    image_data = base64.b64decode(base64_string)
    image = Image.open(BytesIO(image_data))
    return image


def process_image(image):
    
    response = model.generate_content(["Can you extract the items given in the image of the receipt and return to me as an array of json objects. Each json object will be for each item. For each item extract the name, quantity, unit and unit_price.", image])
    print(response.text)
    return response.text

def display_image(image):
    image.show()

def process_receipt(base64_image):
    image = decode_base64_image(base64_image)
    # display_image(image)
    return process_image(image)

def suggest_recipe(itemList):
    prompt = "Suggest a food recipe that can be cooked with: "
    for item in itemList:
        prompt += item + " "
    response = model.generate_content(prompt)
    print(response.text)
    return response.text


@app.route('/run-gen-ai-ocr', methods=['POST'])
def run_gen_ai_ocr():
    # Parse the JSON request payload
    data = request.get_json()

    # Extract the "inputStr" field from the JSON
    input_str = data.get('imageStr')
    # print("imageStr " + str(input_str))
    output = process_receipt(str(input_str))

    # Return the result as a JSON response
    return jsonify({"result": output})

@app.route('/suggest-recipe', methods=['POST'])
def process_recipe_suggestion():
    data = request.get_json()

    if not data or 'itemList' not in data:
        return jsonify({"error": "No items field in request"}), 400

    items = data['itemList']
    print("items: " + str(items))

    if not isinstance(items, list) or not all(isinstance(item, str) for item in items):
        return jsonify({"error": "Invalid items format. Expecting a list of strings."}), 400

    try:
        return suggest_recipe(items)

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)