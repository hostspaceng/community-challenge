import unittest
import requests
from unittest.mock import Mock
from unittest.mock import patch
import os

from main import app

class ProxyTestCase(unittest.TestCase):

    @patch('requests.request')
    def test_proxy(self, mock_request):
        """Test that the proxy returns the correct response from Cloudflare."""

        mock_response = Mock()
        mock_response.json.return_value = {'dns_records': [{'name': 'example.com', 'modified_on': 'A', 'content': '1.2.3.4', 'proxied': 'true'}]}
        mock_request.return_value = mock_response

        # Make a request to the proxy
        response = app.test_client().get('/')

        print(response.json['dns_records'])

        # Assert that the response is correct


        assert response.status_code == 200
        assert response.json['dns_records'][0]['name'] == 'example.com'
        assert response.json['dns_records'][0]['modified_on'] == 'A'
        assert response.json['dns_records'][0]['content'] == '1.2.3.4'
        assert response.json['dns_records'][0]['proxied'] == 'true'

       

if __name__ == '__main__':
    unittest.main()

