# README

ローカルでの動かし方

Docker でサービスのビルドを実行
$ docker-compose build

Docker でサービスを立ち上げ
$ docker-compose up -d

コンテナ内に入りデータを migrate

$ docker ps 
$ docker exec -it [コンテナID] bash

$ rails db:migrate

初期データが入っていない場合以下も行う

$ rails db:seed

（ユーザーデータ例）
user_id: user_0
password: password
