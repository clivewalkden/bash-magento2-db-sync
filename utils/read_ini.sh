#!/usr/bin/env bash

__shini_parsed()
{
    declare $2=\"$3\"
}

shini_parse "$ini_file"

printenv