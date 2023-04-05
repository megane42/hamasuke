#!/bin/bash -e

dotenv copilot svc deploy --env staging --name web
dotenv copilot svc deploy --env staging --name worker
