# デプロイ

- `dotenv` が必要なのは、docker build args に `BUNDLE_GITHUB__COM` を渡す必要があるため

```sh
AWS_PROFILE=fukusuke dotenv copilot svc deploy
```

# DB マイグレーション

```sh
AWS_PROFILE=fukusuke ./run_task.sh -e staging -c "bundle exec rails db:migrate db:seed"
```
