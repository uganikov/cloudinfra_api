# README

## ユーザ作成
curl -X POST  -H 'Content-Type:application/json' -d '{ "name": "cloudinfra", "password": "cloudinfra01", "password_confirmation" : "cloudinfra01", "email" : "a1901sa@aiit.ac.jp"}' http://0.0.0.0:3000/users

## ログイン (APIトークン取得)
curl -X POST  -H 'Content-Type:application/json' -d '{ "password": "cloudinfra01", "email" : "a1901sa@aiit.ac.jp"}' http://0.0.0.0:3000/users/login

## 秘密鍵取得
curl -X GET -H 'Authorization: Token APIトークン' http://0.0.0.0:3000/user/identity

## インスタンス作成
curl -X POST  -H 'Authorization: Token APIトークン' -H 'Content-Type:application/json' -d '{"type":"normal", "ip":"20"}' http://0.0.0.0:3000/instances

## インスタンス停止
curl -X DELETE -H 'Authorization: Token APIトークン' http://0.0.0.0:3000/instances/インスタンスID
