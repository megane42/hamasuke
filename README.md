# インフラ構築

- [こちら](/CREATE_INFRASTRUCTURE.md) を参照

# デプロイ

- `dotenv` が必要なのは、docker build args に `BUNDLE_GITHUB__COM` を渡す必要があるため

```sh
AWS_PROFILE=hamasuke dotenv copilot svc deploy
```

# DB マイグレーション

- コンテナ起動時に [bin/docker-entrypoint](/bin/docker-entrypoint) が実行されるように調整すると、意識しなくてよくなるかも

```sh
AWS_PROFILE=hamasuke ./run_task.sh -e staging -c "bundle exec rails db:migrate db:seed"
```
