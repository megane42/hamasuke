# インフラ作成手順

## 前提

- fukusuke リポジトリをコピーして hamasuke 環境を作ったときのメモです

## fukusuke をクローン

```
git clone https://github.com/giftee/fukusuke.git hamasuke
git remote remove origin
git remote add origin https://github.com/megane42/hamasuke.git
```

## アプリ名の一括修正

```
git grep -l 'fukusuke' | xargs sed -i '' -e 's/fukusuke/hamasuke/g'
git grep -l 'Fukusuke' | xargs sed -i '' -e 's/Fukusuke/Hamasuke/g'
git grep -l 'FUKUSUKE' | xargs sed -i '' -e 's/FUKUSUKE/HAMASUKE/g'
```

## terraform (base) 修正

- ドメイン名だけプロダクトごとに修正が必要
  - terraform/staging_base/acm.tf
  - terraform/production_base/acm.tf

## terraform (base) 実行

```
AWS_PROFILE=fukusuke terraform init
AWS_PROFILE=fukusuke terraform plan
AWS_PROFILE=fukusuke terraform apply
```
## copilot 修正

- copilot/environments/staging/manifest.yml
  - network.vpc
  - network.vpc.subnets
  - ~~http.public~~
    - この時点ではいったんコメントアウトしておく
- copilot/environments/production/manifest.yml
- copilot/web/manifest.yml
  - ~~environments.staging.http.alias~~
    - この時点ではいったんコメントアウトしておく
  - environments.staging.network.vpc.security_groups
  - ~~environments.production.http.alias~~
    - この時点ではいったんコメントアウトしておく
  - environments.production.network.vpc.security_groups
- copilot/worker/manifest.yml
  - environments.staging.network.vpc.security_groups
  - environments.production.network.vpc.security_groups

## copilot env まで作成

- 前のステップで env manifest を修正しているので、実はここのオプションは適当でいい説がある

```
AWS_PROFILE=fukusuke copilot app init hamasuke

AWS_PROFILE=fukusuke copilot env init                                        \
  --name                   staging                                           \
  --import-vpc-id          vpc-04d4ca8facff399d0                             \
  --import-public-subnets  subnet-056daf1f6acc5beea,subnet-0f8006381fecccbbd \
  --import-private-subnets subnet-01e1c0525545a2de2,subnet-040feeb383a791a3a

AWS_PROFILE=fukusuke copilot env init                                        \
  --name                   production                                        \
  --import-vpc-id          vpc-0e007ac466de3f614                             \
  --import-public-subnets  subnet-0c67abbd39033a91e,subnet-0a6ddbfb74782206d \
  --import-private-subnets subnet-046ee880d58eebe0a,subnet-0a58b5afc60deb707

AWS_PROFILE=fukusuke copilot env deploy --name staging
AWS_PROFILE=fukusuke copilot env deploy --name production
```

## copilot 環境変数適用

- AWS CLI で下記のように取得しつつ、jq や手作業を駆使していい感じに yaml を作る

```
aws ssm get-parameters-by-path --path "/copilot/hamasuke/staging"    --recursive --with-decryption
aws ssm get-parameters-by-path --path "/copilot/hamasuke/production" --recursive --with-decryption
```

- 作った yaml を使って parameter store にインポート

```
AWS_PROFILE=fukusuke copilot secret init --cli-input-yaml /tmp/secrets.yml
```

## copilot svc まで作成

```
AWS_PROFILE=fukusuke copilot svc init --app hamasuke --name web    --svc-type "Load Balanced Web Service"
AWS_PROFILE=fukusuke copilot svc init --app hamasuke --name worker --svc-type "Backend Service"

AWS_PROFILE=fukusuke dotenv copilot svc deploy --env staging --name web
AWS_PROFILE=fukusuke dotenv copilot svc deploy --env staging --name worker
AWS_PROFILE=fukusuke dotenv copilot svc deploy --env production --name web
AWS_PROFILE=fukusuke dotenv copilot svc deploy --env production --name worker
```

## ドメイン取得

- 例のリポジトリに、新ドメインを作る PR を出す

## copilot マニフェストを微修正

- 前のステップでいったんコメントアウトしておいた http alias 関連を有効にして、copilot env deploy と copilot svc deploy をやり直す
    - このメモを書いたときはこの手順で作業したが、よく見たら copilot/web/manifest.yml のドメインを間違えてたので、もしかしたらそこを正せば「いったんコメントアウト」のステップは要らなかったかもしれない

## terraform (after_copilot) 修正

- copilot で作られた ALB の ARN を書く
  - terraform/staging_after_copilot/wafv2_web_acl_association.tf
  - terraform/production_after_copilot/wafv2_web_acl_association.tf

## terraform (after_copilot) 実行

- コマンドは base と同じなので割愛
