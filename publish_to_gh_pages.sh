    fvm flutter build web --release --no-tree-shake-icons
    git push origin --delete gh-pages
    git add build/web/ -f
    git commit -m "publish new web version"
    git push
    git subtree push --prefix build/web origin gh-pages