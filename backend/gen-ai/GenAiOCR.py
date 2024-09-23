import base64
from io import BytesIO
from PIL import Image
import google.generativeai as genai
import os
from flask import Flask, request, jsonify


genai.configure(api_key="KEY")
app = Flask(__name__)


def decode_base64_image(base64_string):
    image_data = base64.b64decode(base64_string)
    image = Image.open(BytesIO(image_data))
    return image


def process_image(image):
    model = genai.GenerativeModel('gemini-1.5-flash-001')
    response = model.generate_content(["Can you extract the items given in the image of the receipt and return to me as an array of json objects. Each json object will be for each item. For each item extract the name, quantity, unit and unit_price.", image])
    print(response.text)
    return response.text

def display_image(image):
    image.show()

def process_receipt(base64_image):
    image = decode_base64_image(base64_image)
    # display_image(image)
    return process_image(image)


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


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)