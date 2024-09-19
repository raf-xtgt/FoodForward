import base64
from io import BytesIO
from PIL import Image
import google.generativeai as genai
import os


genai.configure(api_key="AIzaSyBCDfNTYEDDhlWyv4vcvviSX75W9h2ACV8")


def decode_base64_image(base64_string):
    image_data = base64.b64decode(base64_string)
    image = Image.open(BytesIO(image_data))
    return image


def process_image(image):
    model = genai.GenerativeModel('gemini-1.5-flash-001')
    response = model.generate_content(["Can you extract the items given in the image of the receipt and return to me as an array of json objects. Each json object will be for each item.", image])
    print(response.text)
    return response.text

def display_image(image):
    image.show()

def process_receipt(base64_image):
    image = decode_base64_image(base64_image)
    display_image(image)
    process_image(image)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python script.py <base64_image_string>")
        sys.exit(1)

    base64_image = sys.argv[1]  # Accept base64 string as command-line argument
    output = process_receipt(base64_image)
    print(output)