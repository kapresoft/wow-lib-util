#!/usr/bin/env sh

./dev/run-lua assert \
  && ./dev/run-lua mixin \
  && ./dev/run-lua string \
  && ./dev/run-lua table
