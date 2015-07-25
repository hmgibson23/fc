#!/usr/bin/env bash

rbenv local 2.2.0
bundle exec thin --timeout 0 -R config.ru start
