#!/bin/bash

export PROTON_PASS_KEY_PROVIDER=fs

eval $(ssh-agent)

pass-cli ssh-agent load
