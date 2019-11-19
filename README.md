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
curl -X PUT -H 'Authorization: Token APIトークン' -application/json' -d '{"status":"0"}' http://0.0.0.0:3000/instances/インスタンスID

## インスタンス開始
curl -X PUT -H 'Authorization: Token APIトークン' -application/json' -d '{"status":"1"}' http://0.0.0.0:3000/instances/インスタンスID

## インスタンス破棄
curl -X DELETE -H 'Authorization: Token APIトークン' http://0.0.0.0:3000/instances/インスタンスID
稼働中のインスタンスは停止してから破棄を行うため、稼働中のインスタンスに対して実行してもエラーとはならない

## 全インスタンス破棄 (very experimental)
curl -X DELETE -H 'Authorization: Token APIトークン' http://0.0.0.0:3000/instances
稼働中の全インスタンスを破棄する。なんの整合性の確認もとらないので注意
