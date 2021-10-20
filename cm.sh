#!/bin/bash

case $1 in
    update )
        emoji=':zap:'
        ;;
    add )
        emoji=':sparkles:'
        ;;
    config )
        emoji=':wrench:'
        ;;
    fix )
        emoji=':bug:'
        ;;
    init )
        emoji=':tada:'
        ;;
    remove )
        emoji=':fire:'
        ;;
    wip )
        emoji=':construction:'
        ;;
    break )
        emoji=':boom:'
        ;;
    ignore )
        emoji=':see_no_evil'
        ;;
    typo )
        emoji=':pencil2:'
        ;;
    refactor )
        emoji=':recycle:'
        ;;
    test )
        emoji=':test_tube:'
        ;;
    * )
      echo 'Usage:
    $ cm operator [commit]
Operator
    update 更新代码
    add    添加代码、feature
    config 添加、修改配置
    fix    修复 bug
    init   初始化
    remove 移除文件
    wip    工作暂存
    break  破坏性更新
    ignore 更新或添加 .gitignore
    typo   打字错误
    refactor 重构
    test   测试
'
        ;;
esac

if [ $emoji ]; then  
  git status
  if [ $2 ]; then
    emojify "commit: $emoji $2"
    git commit -m "$emoji $2"
  else
    read -p "$1: $(emojify $emoji) " commit
    git commit -m "$emoji $commit"
  fi
fi
