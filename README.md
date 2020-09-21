## slack_messages_remover
with AWS Lambda

###### 所感  
非推奨のLegacyTokenじゃなくて、SlackのConfigurationからアプリ作成して  
必要なscope付与して、公式のAPI内のTesterから通るかチェックして..😇  
deprecatedなメソッドもちらほら

## 手順
### 1. Slack側でアプリを作成
https://api.slack.com/apps

<img src="" width="710">(ここに画像)


### 2. 作成したアプリに権限を付与

1. で作成したアプリの `Permission` を選択

WorkSpaceのチャンネル一覧を取得して  
チャンネルのチャット一覧を取得、特定のチャットを削除  
までに必要な権限(スコープ)は以下  
- channels:history
- groups:history
- im:history
- mpim:history
- channels:read
- groups:read
- im:read
- mpim:read
- chat:write

`Bot Token Scopes` と `User Token Scopes`  
どちらとして実行する時も必要な権限はたぶん一緒  

##### ハマりポイント  
権限を変更した場合、WorkSpaceにアプリを再インストールする必要があるが  
再インストールのボタンを押して、ページが更新されても  
ページのヘッダーに**黄色いバーが出ている状態は、処理が正常に終了していない**  
**ここですごいハマった。**  
アプリに必要な権限付与できているはずなのに、APIがScope云々エラー言われる😢  


### 3. アプリをWorkSpaceに追加
無料枠の場合、IntegrationApp(incoming webhook等)とあわせて  
登録できるのは10個まで


### 4. TesterでコマンドをAPI経由で叩いて通るかチェック
例: チャット一覧を取得:conversations.list  
https://api.slack.com/methods/conversations.list/test  
  
トークンやらチャンネルなど必要な値を入れて  
`Test Method` を押すと結果がパラメータとして返ってくる  
権限不足の場合は必要なスコープがずらずら表示される  

叩きたいAPIが全て正常に動作することを確認したら  
ようやく自分のアプリケーション側に実装できる



