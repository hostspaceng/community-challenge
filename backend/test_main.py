import unittest
from main import app
import requests

class TestFlaskApp(unittest.TestCase):
    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

    def test_proxy_route(self):
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.content_type, 'application/json')

    def test_proxy_route_content(self):
        response = self.app.get('/')
        data = response.get_json()
        print(data)
        self.assertTrue(data['success'])  # Check if 'success' is True
        self.assertEqual(len(data['result']), 2)  # Check if there are 2 results

if __name__ == '__main__':
    unittest.main()
