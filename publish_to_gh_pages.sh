fvm flutter build web --release --no-tree-shake-icons

# Create CNAME file with custom domain
echo "moxifymtg.com" > build/web/CNAME

git add build/web/ -f
git commit -m "publish new web version"
git pull origin gh-pages --rebase
git push origin $(git subtree split --prefix build/web):gh-pages --force