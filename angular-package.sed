#!/usr/bin/env sed
s/localhost/0.0.0.0/g
s/\(bower \)\([^"']*\)/\/var\/lib\/angular\/node_modules\/\.bin\/\1\2/g

