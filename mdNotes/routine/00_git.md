1️⃣ 先 git add + git commit
把你本地改动提交到本地仓库：

git add .
git commit -m "你的提交说明"

2️⃣ 再 git push
把本地提交同步到远程：

git push origin main


总结：
git add .
git commit -m "说明"
git pull --rebase origin main   # 可选，保证远程更新整合
git push origin main