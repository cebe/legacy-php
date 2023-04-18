#!/bin/sh

KEYS=""
KEYS="$KEYS 33CFC8B3" # Ferenc Kovacs <tyrael@php.net>
KEYS="$KEYS 9C0D5763" # Anatol Belski <ab@php.net>
KEYS="$KEYS 90D90EC1" # Julien Pauli <jpauli@php.net>
KEYS="$KEYS 7267B52D" # David Soria Parra <dsp@php.net>
KEYS="$KEYS 5DA04B5D" # Stanislav Malyshev (PHP key) <stas@php.net>
KEYS="$KEYS FC9C83D7" # Johannes Schlüter <johannes@php.net>
KEYS="$KEYS 70D12172" # Sara Golemon <pollita@php.net>
KEYS="$KEYS EE5AF27F" # Remi Collet <remi@php.net>
KEYS="$KEYS F53EA312" # Derick Rethans <derick@derickrethans.nl>
KEYS="$KEYS 4A4EF02D" # Peter Kokot <petk@php.net> 
KEYS="$KEYS 118BCCB6" # Christoph M. Becker <cmb@php.net>

#gpg --keyserver keys.gnupg.net --recv-keys $KEYS
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys $KEYS


