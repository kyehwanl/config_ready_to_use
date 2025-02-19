#!/usr/bin/expect -f

set timeout -1
spawn git push --force --all origin 

expect "Username*"
send -- "user\r"
expect "Password*"
send -- "ghp_iC...........jRXpr\r"   # token
send "\r"
expect eof

