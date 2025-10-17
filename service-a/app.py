
---

## `service-a/app.py`
```python
from flask import Flask, jsonify
import requests
import os

app = Flask(__name__)

SERVICE_B_URL = os.environ.get("SERVICE_B_URL", "http://service-b:5000")

@app.route("/")
def root():
    try:
        r = requests.get(f"{SERVICE_B_URL}/")
        b = r.text
    except Exception as e:
        b = f"error calling service-b: {e}"
    return jsonify({"service": "service-a", "message": "Hello from service A", "service_b": b})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
