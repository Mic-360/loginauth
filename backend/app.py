from flask import Flask, request, jsonify
from flask_socketio import SocketIO
from flask_sqlalchemy import SQLAlchemy

app: Flask = Flask(__name__)

app.config['SECRET_KEY'] = 'secret'
app.config['SESSION_TYPE'] = 'filesystem'
app.config['transports'] = ['websocket']


socketio = SocketIO(app, cors_allowed_origins='*')


app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'
db = SQLAlchemy(app)

class users:
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(120))
    password = db.Column(db.String(80))


@app.route('/login', methods=['GET', 'POST'])
def login():
    d = {}
    if request.method == "POST":
        mail = request.form["email"]
        password = request.form["password"]

        login = users.query.filter_by(email=mail, password=password).first()

        if login is None:
            return jsonify(["Wrong Credentials"])
        else:
            return jsonify(["Success"])


if __name__ == '__main__':
    socketio.run(app, debug=True)
