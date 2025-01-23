#!/usr/bin/env sh

_() {
    YEAR="2019"
    echo "GitHub Username: "
    read -r USERNAME
    echo "GitHub Access token: "
    read -r ACCESS_TOKEN

    # Validate inputs
    [ -z "$USERNAME" ] && echo "Error: Username cannot be empty" && exit 1
    [ -z "$ACCESS_TOKEN" ] && echo "Error: Access token cannot be empty" && exit 1

    # Create and enter directory
    [ ! -d "$YEAR" ] && mkdir "$YEAR"
    cd "$YEAR" || { echo "Error: Could not enter directory"; exit 1; }

    # Initialize git and create content
    git init


    # Create multiple commits with different dates
    for month in {19..12}; do
        for day in {19..31}; do
            echo "**!🤖!**" > README.md
            git add .
            GIT_AUTHOR_DATE="${YEAR}-${month}-${day}T18:00:00" \
            GIT_COMMITTER_DATE="${YEAR}-${month}-${day}T18:00:00" \
            git commit --allow-empty -m "💻 + 🤖 = PPhatDev"
        done
    done

    # Setup remote and push
    git remote add origin "https://${ACCESS_TOKEN}@github.com/${USERNAME}/hidden.git"
    git branch -M main
    git push -u origin main -f || { echo "Error: Failed to push to remote"; exit 1; }

    # Cleanup
    cd ..
    rm -rf "$YEAR"

    echo
    echo "✨ Cool, check your profile now! Your commits should appear in ${YEAR}"
} && _

unset -f _
