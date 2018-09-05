# DotFiles

## INTRODUCTION

Here is my dotfiles for my system.

## CINNAMON CONFIG

```
dconf dump /org/cinnamon/ > backup_of_my_cinnamon_settings
```
backup_of_my_cinnamon_settings is backup file

```
dconf load /org/cinnamon/ < backup_of_my_cinnamon_settings
```
load config

```
dconf reset -f /org/cinnamon/
```
reset default
