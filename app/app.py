from flask import Flask, jsonify
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST

app = Flask(__name__)

APP_VERSION = "1.1.0"

REQUEST_COUNT = Counter(
    "app_http_requests_total",
    "Total number of HTTP requests",
    ["method", "endpoint"]
)


@app.before_request
def track_request():
    from flask import request
    REQUEST_COUNT.labels(
        method=request.method,
        endpoint=request.path
    ).inc()


@app.route("/")
def home():
    return jsonify({
        "application": "GitOps AKS Demo",
        "version": APP_VERSION,
        "message": "GitOps deployment v1.1.0 is running successfully"
    })


@app.route("/health")
def health():
    return jsonify({
        "status": "healthy"
    })


@app.route("/version")
def version():
    return jsonify({
        "version": APP_VERSION
    })


@app.route("/metrics")
def metrics():
    return generate_latest(), 200, {
        "Content-Type": CONTENT_TYPE_LATEST
    }


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8081)