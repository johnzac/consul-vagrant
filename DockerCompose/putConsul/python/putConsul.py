from flask import Flask,request
from flup.server.fcgi import WSGIServer
app = Flask(__name__)
@app.route('/putServers',methods=['POST'])
def putServers():
    req=request.get_data()
    file=open("/var/www/html/servers2.json","w")
    file.write(req)
    file.close()
    return "done"
WSGIServer(app, bindAddress=('0.0.0.0',8888)).run()

