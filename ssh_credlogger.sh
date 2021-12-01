#!/bin/sh

# comment the next line out if you're not doing a Slack webhook
curl -X POST https://hooks.slack.com/workflows/your_webhook_here -d "{\"user\": \"$1\", \"server\": \"$2\", \"host\": \"$3\", \"logpath\": \"$4\"}"

ssh $5 $6 $7
