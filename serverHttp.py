from flask import Flask, request, redirect, url_for
import os

app = Flask(__name__)

UPLOAD_FOLDER = "/usr/lib/balance-app-mainland/.dart_tool/productImages"

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['MAX_CONTENT_LENGTH'] = 1024*1024

@app.route('/upload',methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return "No se ha mandado un archivo",400
    
    file = request.files['file']

    if file.filename == '':
        return "No se selecciono ningun archivo", 400
    
    if file:
        filepath = os.path.join(app.config['UPLOAD_FOLDER'],file.filename)
        file.save(filepath)
        return f'Archivo cargado exitosamente en {filepath}', 200 
    
if __name__ == '__main__':
    app.run(host='0.0.0.0',port=5000)