#!/usr/bin/env sh

_() {
    YEAR="2025"
    echo "GitHub Username: "
    read -r USERNAME
    echo "GitHub Access token: "
    read -r ACCESS_TOKEN

    [ -z "$USERNAME" ] && exit 1
    [ -z "$ACCESS_TOKEN" ] && exit 1
    [ ! -d $YEAR ] && mkdir $YEAR

    cd "2025" || exit
    git init
    echo "**🫡Welcome back to 2025** \
        >README.md
    git add .
    GIT_AUTHOR_DATE="2025-01-15T18:00:00" \
        GIT_COMMITTER_DATE="2025-01-15:00:00" \
        git commit -m "2025"
    git remote add origin "https://${ACCESS_TOKEN}@github.com/${USERNAME}/2001-script.git"
    git branch -M main
    git push -u origin main -f
    cd ..
    rm -rf "2025"

    echo
    echo "Cool, check your profile now: https://github.com/${USERNAME}"
} && _

unset -f _