# Webアプリケーション勉強会用環境構築Playbook

## 前提

- macOS Sierra以降
- Ubuntu 16.04以降
  - Windows Subsystem for Linux（以下WSL）含む

ただしログインシェルとして`/bin/bash`を使用していることとします．

### その他のシェルを使用している場合

基本は自分でいい感じにしてください．必要な項目は以下です．

- 環境変数`PIPENV_VENV_IN_PROJECT`を`true`に
- anyenvへの設定（`.$HOME/anyenv`の存在を判定することを推奨します．）
  - `anyenv`コマンドへのパスを通す（`$HOME/.anyenv/bin`）
  - anyenvから他の\*\*envを読み込む
    - `zsh`なら`eval "$(anyenv init -)"`でいいはず
    - `fish`なら`. (anyenv init - fish | psub)`でいい

基本的にこのplaybookを使用するよりも．下記の手動構築手順を参照し，自力で構築した方が良いと思います．

### WSLのインストール

Windows10で参加される方はWSLが必須です．下記記事を参照し，インストールしておいてください．

http://www.atmarkit.co.jp/ait/articles/1608/08/news039.html

## 自動構築手順

CUIでの環境構築をあまり/全くしたことがない，WSLの扱いに慣れていない，pyenvやpipenvを使用したことがない，などの場合，脳死でこちらの手順に従うことを推奨します．  
ただし既存の開発環境は保証しません．


### 1. このリポジトリをクローン

ターミナルを開き，下記コマンドを実行してください．

```bash
$ sudo apt update -y && sudo apt upgrade -y
$ git clone https://github.com/StudioAquatan/webapp-practice-playbook
```

以降，このリポジトリ内で操作を行います．

```bash
$ cd webapp-practice-playbook
```

### 2. Ansibleをインストール

初期セットアップスクリプトを実行します．途中でsudoパスワードなどいくつかのプロンプトが出ます．

```bash
$ bash install_ansible.sh
```

検証はしていますが，このスクリプト単体で必ず上手くいくとは言い切れません．環境によって左右されるため，このスクリプトの実行に失敗した場合，Ansibleをインストールする方法を検索して手動で実行してください．

### 3. playbookの実行

Ansibleのplaybookを実行します．

```bash
$ ansible-playbook setup.yml -K
```

`-K`オプションにより実行時にsudoパスワードを聞かれます．また，Pythonのビルド及びその依存関係解消を含むため，実行にそれなりの時間を要します．

**注意**
実行時に`[WARNING] Ansible is in a world writable directory`などの警告が表示される場合，下記issueに従ってコマンドを実行してください．
[issue #1](https://github.com/StudioAquatan/webapp-practice-playbook/issues/1)

 
