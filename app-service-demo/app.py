from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Azure App Service PaaS lab is working."