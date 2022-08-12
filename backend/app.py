from flask import Flask, request, jsonify
from flask_socketio import SocketIO
from flask_sqlalchemy import SQLAlchemy

app: Flask = Flask(__name__)

app.config['SECRET_KEY'] = 'secret'
app.config['SESSION_TYPE'] = 'filesystem'
app.config['transports'] = ['websocket']


socketio = SocketIO(app, cors_allowed_origins='*')


app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///users.database'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)


class Users(db.Model):
    _id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(120))
    password = db.Column(db.String(80))
    def __repr__(self):
        return f'<Users: {self._id, self.email, self.password}>'


@app.route('/database')
def Database():
    du = {}
    for user in Users.query.all():
        du[user._id] = {'email': user.email, 'password': user.password}
    return jsonify(du)


@app.route('/login', methods=['GET', 'POST'])
def Login():
    d = {}
    for user in Users.query.all():
        d = {'email': user.email, 'password': user.password}

    if request.method == "POST":
        email = request.form["email"]
        password = request.form["password"]

        login = Users.query.filter_by(email=email, password=password).first()

        if login is None:
            d['status'] = 304
            return jsonify(["Invalid email or password"])
        else:
            d['status'] = 200
            return jsonify(["Logged in Success"])
    return jsonify(d)


if __name__ == '__main__':
    db.create_all()
    socketio.run(app, debug=True)
