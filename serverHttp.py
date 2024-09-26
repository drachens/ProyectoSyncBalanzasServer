from flask import Flask, request, redirect, url_for
from flask_cors import CORS
import os

app = Flask(__name__)
CORS(app)
UPLOAD_FOLDER = "/usr/lib/balance-app-mainland/.dart_tool/productImages"

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['MAX_CONTENT_LENGTH'] = 1024*1024*3

@app.route('/upload',methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return "No se ha mandado un archivo",401
    
    file = request.files['file']
    new_filename = request.form.get('newFileName')

    if file.filename == '':
        return "No se selecciono ningun archivo", 402
    
    if file:
        filepath = os.path.join(app.config['UPLOAD_FOLDER'],new_filename)
        file.save(filepath)
        return f'Archivo cargado exitosamente en {filepath}', 200 
    
@app.route('/listImages', methods=['GET'])
def list_images():



if __name__ == '__main__':
    app.run(host='0.0.0.0',port=5000,debug=True)