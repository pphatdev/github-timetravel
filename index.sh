#!/usr/bin/env sh

_() {
    # Prompt for GitHub credentials
    read -p "GitHub Username: " -r USERNAME
    printf "GitHub Access Token: "
    stty -echo
    read -r ACCESS_TOKEN
    stty echo
    echo

    # Prompt for repository details
    read -p "Repository name (default: YEAR): " -r REPO_NAME
    read -p "Year (e.g., 2001): " -r YEAR
    read -p "Month (01-12, default: 10): " -r MONTH
    read -p "Day (01-31, default: 10): " -r DAY

    # Validate inputs
    [ -z "$USERNAME" ] && { echo "Error: GitHub Username is required."; exit 1; }
    [ -z "$ACCESS_TOKEN" ] && { echo "Error: GitHub Access Token is required."; exit 1; }
    [ -z "$YEAR" ] && YEAR="2001"
    [ -z "$REPO_NAME" ] && REPO_NAME="$YEAR"
    [ -z "$MONTH" ] && MONTH="10"
    [ -z "$DAY" ] && DAY="10"

    # Check if repository already exists on GitHub
    REPO_EXISTS=$(curl -s -o /dev/null -w "%{http_code}"         -H "Authorization: token $ACCESS_TOKEN"         "https://api.github.com/repos/${USERNAME}/${REPO_NAME}")

    if [ "$REPO_EXISTS" -eq 200 ]; then
        echo "⚠️ Warning: Repository '${REPO_NAME}' already exists on GitHub."
        read -p "Do you want to proceed and risk overwriting existing commits? (y/n): " -r CONFIRM
        if [ "$CONFIRM" != "y" ]; then
            echo "Aborted."
            exit 1
        fi
    fi

    # Create repository directory
    [ ! -d "$REPO_NAME" ] && mkdir "$REPO_NAME"
    cd "${REPO_NAME}" || exit

    # Initialize Git repository
    git init

    # Create README.md
    cat > README.md <<'EOF'
# 🚀 Time Travel to [YEAR]

This repository was dynamically generated for the year **[YEAR]** using the [github-timetravel](https://github.com/github-timetravel/timetravel) script.

---

## 📜 Purpose
This repository simulates a "time travel" effect by backdating a GitHub repository to a specific year, month, and day.

---

## 🛠️ Usage
1. **Clone this repository** to your local machine:
   ```sh
   git clone https://github.com/[USERNAME]/[REPO_NAME].git
   ```
2. **View the commit history** to see the backdated entries:
   ```sh
   git log
   ```

---
## 📝 How It Works
- The script creates a new Git repository with a single commit backdated to the specified year, month, and day.
- The commit message is set to the year (e.g., `2001`).
- The repository is then pushed to GitHub, creating the illusion of a historical contribution.

---
## 🔧 Customization
- **Year**: The year for the backdated commit (default: `2001`).
- **Month**: The month for the backdated commit (default: `10`).
- **Day**: The day for the backdated commit (default: `10`).

---
## 📌 Notes
- This is purely for fun and does not actually modify GitHub's historical data.
- Ensure you have a valid **GitHub Access Token** with repository creation permissions.
- The repository name defaults to the year if not specified.

---
## 📅 Generated On
This repository was generated on [CURRENT_DATE].
EOF

    # Replace placeholders in README.md
    sed -i "s/\[YEAR\]/$YEAR/g" README.md
    sed -i "s/\[USERNAME\]/$USERNAME/g" README.md
    sed -i "s/\[REPO_NAME\]/$REPO_NAME/g" README.md
    sed -i "s/\[CURRENT_DATE\]/$(date '+%Y-%m-%d')/g" README.md

    # Add and commit files
    git add .
    GIT_AUTHOR_DATE="${YEAR}-${MONTH}-${DAY}T18:00:00"         GIT_COMMITTER_DATE="${YEAR}-${MONTH}-${DAY}T18:00:00"         git commit -m "${YEAR}"

    # Push to GitHub (only force-push if repository is new)
    git remote add origin "https://${ACCESS_TOKEN}@github.com/${USERNAME}/${REPO_NAME}.git"
    git branch -M main
    if [ "$REPO_EXISTS" -eq 200 ]; then
        git push -u origin main
    else
        git push -u origin main -f
    fi

    # Cleanup
    cd ..
    rm -rf "${REPO_NAME}"

    echo
    echo "✅ Success! Check your profile: https://github.com/${USERNAME}"
} && _

unset -f _
