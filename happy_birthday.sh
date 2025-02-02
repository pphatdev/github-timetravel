#!/usr/bin/env sh

_() {
    YEAR="2001"
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
    echo "**🥳 Happy birthday to me!**" > README.md
    git add .

    # Set commit dates and create commit
    GIT_AUTHOR_DATE="${YEAR}-10-10T18:00:00" \
    GIT_COMMITTER_DATE="${YEAR}-10-10T18:00:00" \
    git commit -m "🥳 Happy birthday to me!"

    # Setup remote and push
    git remote add origin "https://${ACCESS_TOKEN}@github.com/${USERNAME}/leatsophat.me.git"
    git branch -M main
    git push -u origin main -f || { echo "Error: Failed to push to remote"; exit 1; }
    
    # Cleanup
    cd ..
    rm -rf "$YEAR"

    echo
    echo "✨ Cool, check your profile now! Your commit should appear in ${YEAR}"
} && _

unset -f _