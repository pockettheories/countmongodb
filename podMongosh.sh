#!/usr/bin/env bash
kubectl run msh --image=mongo -it -n try1 --command -- mongosh 'mongodb://mdb-svc'
