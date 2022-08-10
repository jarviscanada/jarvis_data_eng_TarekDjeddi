import requests
import sys


def find_company_info(ticker):
    url = "https://google-finance4.p.rapidapi.com/ticker/"

    querystring = {"t": f"{ticker}", "hl": "en", "gl": "US"}

    headers = {
        "X-RapidAPI-Key": "be4e79ed81msh3f8e0be70e5a6f9p145377jsn3ce15b0cab0e",
        "X-RapidAPI-Host": "google-finance4.p.rapidapi.com"
    }

    response = requests.request("GET", url, headers=headers, params=querystring)
    output = response.json()

    print(output['info']['title'])
    print(output['about']['ceo'])
    print(output['price']['previous_close'])

ticker = sys.argv[1]
find_company_info(ticker)