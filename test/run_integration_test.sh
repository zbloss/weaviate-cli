#!/bin/bash

set -e

mkdir -p "$HOME/.config/semi_technologies/"
echo '{"url": "http://localhost:8080", "auth": null}' > "$HOME/.config/semi_technologies/configs.json"

python -m unittest test/unit_test.py 

docker-compose -f test/docker-compose.yaml up -d

sleep 5

python -m unittest test/integration_test.py

docker-compose -f test/docker-compose.yaml down 

python cli.py config view
