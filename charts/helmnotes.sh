#!/bin/bash

# Create new chart

helm create -h
helm create gitlab-omnibus

# Find out deployment spec syntax for persistent volumes

kubectl explain deployment.spec.template.spec.containers.volumeMounts

