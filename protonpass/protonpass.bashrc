#!/bin/bash

eval $(ssh-agent)

pass-cli ssh-agent load
