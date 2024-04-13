import os
import subprocess

def clone_cdc_repo(cdc_repo_url, enterprise_github_username, enterprise_repo_name):
    enterprise_github_token = os.getenv("ENTERPRISE_GITHUB_TOKEN")
    
    # Clone the repository from CDC GitHub
    try:
        subprocess.run(["git", "clone", cdc_repo_url])
        print("Repository cloned successfully from CDC GitHub.")
    except subprocess.CalledProcessError as e:
        print("Error cloning repository from CDC GitHub:", e)
        exit(1)
    
    # Change directory to the cloned repository
    os.chdir(enterprise_repo_name)
    
    # Add the enterprise GitHub repository as a remote
    enterprise_github_url = f"https://{enterprise_github_username}:{enterprise_github_token}@github.enterprise.com/{enterprise_github_username}/{enterprise_repo_name}.git"
    try:
        subprocess.run(["git", "remote", "add", "enterprise", enterprise_github_url])
        print("Enterprise GitHub remote added successfully.")
    except subprocess.CalledProcessError as e:
        print("Error adding enterprise GitHub remote:", e)
        exit(1)
    
    # Push the code to the enterprise GitHub repository
    try:
        subprocess.run(["git", "push", "enterprise", "--mirror"])
        print("Code successfully pushed to enterprise GitHub.")
    except subprocess.CalledProcessError as e:
        print("Error pushing code to enterprise GitHub:", e)
        exit(1)
    
    # Create catalog-info.yml file
    with open("catalog-info.yml", "w") as file:
        file.write("# Enter your catalog information here")

if __name__ == "__main__":
    # CDC GitHub repository details
    cdc_repo_url = "https://github.com/CDCgov/covid_case_privacy_review.git"
    
    # Enterprise GitHub credentials and repository details
    enterprise_github_username = "your_github_username"
    enterprise_repo_name = "your-enterprise-repo"  # Replace with the name of your enterprise repo
    
    # Clone CDC repo, push to enterprise GitHub, and create catalog-info.yml
    clone_cdc_repo(cdc_repo_url, enterprise_github_username, enterprise_repo_name)
---

name: Clone CDC Repo and Push to Enterprise GitHub

on:
  push:
    branches:
      - main

jobs:
  clone_and_push:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v2

      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.x'

      - name: Install dependencies
        run: |
          pip install -r requirements.txt
          pip install requests  # Install requests library

      - name: Run Python Script
        run: |
          python script.py
          # Comment out the following lines if not needed
          # python scripts/azure_devops_to_enterprise_github.py
        env:
          ENTERPRISE_GITHUB_TOKEN: ${{ secrets.ENTERPRISE_GITHUB_TOKEN }}
---

name: Clone CDC Repo and Push to Enterprise GitHub

on:
  push:
    branches:
      - main

jobs:
  clone_and_push:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v2

      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.x'

      - name: Install dependencies
        run: |
          pip install -r requirements.txt
          pip install requests  # Install requests library

      - name: Run Python Script
        run: |
          python script.py
          # Comment out the following lines if not needed
          # python scripts/azure_devops_to_enterprise_github.py
        env:
          ENTERPRISE_GITHUB_TOKEN: ${{ secrets.ENTERPRISE_GITHUB_TOKEN }}

---

# CDC Repo Cloner

This script automates the process of cloning a repository from the Centers for Disease Control and Prevention (CDC) GitHub account and pushing it to an enterprise GitHub repository.

## Overview

This project is designed to streamline the process of migrating code from a CDC repository to an enterprise GitHub repository. It utilizes a Python script to clone the CDC repository, push the code to the enterprise GitHub repository, and create a `catalog-info.yml` file.

## Usage

### Prerequisites

Before running the script, ensure that you have the following:

- Python 3.x installed on your system
- Access to the CDC GitHub repository
- Access to the enterprise GitHub repository
- Necessary permissions and credentials to push code to the enterprise repository

### Installation

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/your-username/cdc-repo-cloner.git
Navigate to the project directory:

bash
Copy code
cd cdc-repo-cloner
Install the required dependencies:

bash
Copy code
pip install -r requirements.txt
Configuration
Before running the script, you need to configure the following variables in the script file (script.py):

cdc_repo_url: URL of the CDC repository to clone.
enterprise_github_username: Your enterprise GitHub username.
enterprise_repo_name: Name of the repository in your enterprise GitHub account.
Running the Script
To execute the script, run the following command:

bash
Copy code
python script.py
The script will clone the CDC repository, push the code to the enterprise GitHub repository, and create a catalog-info.yml file.

License
  
