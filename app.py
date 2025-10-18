import os
import shutil
import tempfile
import subprocess
# render_templateをインポート
from flask import Flask, request, send_file, render_template # ここを変更

app = Flask(__name__)

# ... (TEMP_DIRの設定や/downloadルートは変更なし) ...

@app.route('/')
def index():
    # index.htmlテンプレートファイルをレンダリング
    return render_template('index.html') 

# ... (/downloadルートは変更なし) ...