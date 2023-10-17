#!/usr/bin/env python3

import json

# Add code to generate dynamic inventory here

# Below is the static example
inventory = {
    "_meta": {
      "hostvars": {
        "reddit-app": {
          "ansible_host": "51.250.93.226"
        },
        "reddit-db": {
          "ansible_host": "158.160.32.253"
        }
      }
    },
    "all": {
      "children": [
        "app",
        "db",
        "ungrouped"
      ]
    },
    "app": {
      "hosts": ["reddit-app"]
    },
    "db": {
      "hosts": ["reddit-db"]
    },
    "ungrouped": {
      "hosts": []
    }
}

print(json.dumps(inventory))
