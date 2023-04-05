#!/bin/bash -e

dotenv copilot svc deploy --env production --name web
dotenv copilot svc deploy --env production --name worker
