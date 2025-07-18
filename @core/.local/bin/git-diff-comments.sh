#!/usr/bin/env bash

OPENAI_API_KEY=$(cat ~/open-ai-key.txt)

data=$(git diff)

prompt="I am getting ready to commit some changes to git. Generate me a well-formed git commit message using the diff I provide: $data"

curl https://api.openai.com/v1/chat/completions \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gpt-4o",
    "messages": [
      {"role": "user", "content": "Hello, world!"}
    ]
  }'
