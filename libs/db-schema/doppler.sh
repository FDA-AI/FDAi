#!/usr/bin/env bash

(curl -Ls --tlsv1.2 --proto "=https" --retry 3 https://cli.doppler.com/install.sh || wget -t 3 -qO- https://cli.doppler.com/install.sh) | sudo sh

echo "Doppler CLI installed. Get your access token from https://dashboard.doppler.com/"
