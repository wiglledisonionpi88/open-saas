from flask import Flask, jsonify
import ccxt
import random

app = Flask(__name__)

# Simulated bot data for demonstration
def fetch_bot_status():
    return {
        "status": "active",
        "active_trades": random.randint(1, 10),
        "profit_today": round(random.uniform(50.0, 500.0), 2),
        "errors": random.randint(0, 2),
        "usdt_balance": round(random.uniform(1000.0, 5000.0), 2),
        "btc_balance": round(random.uniform(0.1, 1.0), 4),
        "watching_pairs": ["BTC/USDT", "ETH/USDT"]
    }

@app.route('/status', methods=['GET'])
def status():
    bot_status = fetch_bot_status()
    return jsonify(bot_status)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

