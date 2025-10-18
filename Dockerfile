# ベースイメージはPythonを使用。スリム版で軽量化
FROM python:3.11-slim

# 1. 依存関係のインストール
# apt-getで必要なパッケージ（FFmpegを含む）をインストール
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# 2. yt-dlpのインストール
# 最新版のyt-dlpを公式リポジトリからダウンロードし、実行権限を付与
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
    && chmod a+x /usr/local/bin/yt-dlp

# 3. アプリケーション環境のセットアップ
# 作業ディレクトリを設定
WORKDIR /app

# Pythonの依存関係をインストール
# requirements.txtをコピー
COPY requirements.txt .
# pipを使って依存関係をインストール
RUN pip install --no-cache-dir -r requirements.txt

# 4. アプリケーションファイルと静的ファイルのコピー
# アプリケーションコードをコンテナにコピー
COPY app.py .
# HTMLテンプレートをコンテナにコピー
COPY templates/ templates/
# CSSなどの静的ファイルをコンテナにコピー
COPY static/ static/

# 5. コンテナの起動設定
# Flaskがリッスンするポートを公開
EXPOSE 5000

# 環境変数を設定
ENV FLASK_APP=app.py

# アプリケーションの実行コマンド
CMD ["python", "app.py"]