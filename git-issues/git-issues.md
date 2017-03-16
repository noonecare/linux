# git

A 分支和 B 分支是否发生冲突，取决于：
A1,A2, ... Am, B1, B2,...Bn
B1,B2,... Bn, A1,A2,..., Am
的结果是否相同。
这样的话， 可以提交在某个分支中添加 提交来解决冲突（使得上面两个结果相同）。实际上也正是这样做的。



git cherry-pick:
我理解的git cherry-pick 是 把 提交 添加到分支上上的操作。 cherry-pick 可能会发生这样的 conflict, 比如 提交是 git rm data_sciene, 而当前 分支根本没有 datascience 文件，这就会报错。



验证修改的是内容还是只是相当于重复执行git指令。
cherry-pick 可以用来论证这个问题，在A分支中 写文件 a, 文件 a 的内容是 "a"， 提交更改 git rm a。
在 B 分支中写个文件 a， 文件内容是 "b"， 把 A 分支的 提交 cherry-pick 到 B 分支，如果顺利执行，说明 只是重复执行命令，如果不是说明 更改的是内容。我认为是后者。
果然如我所料，提交记住的是内容， 不是单纯的重复命令。


Git: 如果你做了错误的提交，最简单的办法是 git revert HEAD, 这样 git 会提交新的提交，新的提交会 undo 错误提交的更改。
但是，在本地版本库，我喜欢 git reset --hard HEAD^ 这样回滚到之前的提交，直接把错误的提交删掉。
现在 如果我已经把 错误的提交 push 到了远程版本库，有没有办法可以在远程版本库删掉 最开头的提交。
git push --force
> 你可以先把本地分支的提交删除，然后使用 git push 时，加上 --force 参数，强推，把 远程分支相应的提交也删除。

git push --delete
> - git push --delete HEAD 把远程的 HEAD 提交（最新提交）删除。


```bashshell
git reset HEAD^
git push orign +HEAD
```
