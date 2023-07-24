# デプロイ

- `dotenv` が必要なのは、docker build args に `BUNDLE_GITHUB__COM` を渡す必要があるため

```sh
AWS_PROFILE=hamasuke dotenv copilot svc deploy
```

# DB マイグレーション

```sh
AWS_PROFILE=hamasuke ./run_task.sh -e staging -c "bundle exec rails db:migrate db:seed"
```
