#!/usr/bin/env sh

./dev/run-lua assert \
  && ./dev/run-lua mixin \
  && ./dev/run-lua string \
  && ./dev/run-lua table \
  && ./dev/run-lua incrementerbuilder \
  && ./dev/run-lua libfactorymixin \
  && ./dev/run-lua luaevaluator
