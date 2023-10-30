from flask import Flask, request, jsonify
from flask_cors import CORS
import requests
import os
from dotenv import load_dotenv

# Load environment variables from .env file during development
load_dotenv()

app = Flask(__name__)
CORS(app)

ZONE_ID = os.getenv('ZONE_ID') or '88212a53b6feba598b197f3508f35b52'
CF_API_KEY = os.getenv('CF_API_KEY') or 'ab590d1c5d3139416fef3d173ad4267a75a41'
CF_API_EMAIL = os.getenv('CF_API_EMAIL') or 'safe@hostspaceng.com'
API_URL = f'https://api.cloudflare.com/client/v4/zones/{ZONE_ID}/dns_records'

@app.route('/', methods=['GET'])
def proxy():
    headers = {
        'X-Auth-Email': CF_API_EMAIL,
        'X-Auth-Key': CF_API_KEY,
        'Content-Type': 'application/json'
    }

    try:
        response = requests.request(
            method='GET',
            url=API_URL,
            headers=headers
        )
    except Exception as e:
        return jsonify({'error': str(e)}), 500

    return response.json()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
